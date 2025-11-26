import 'dart:convert';

import "package:get/get.dart";
import 'package:iot_app/models/orchestrator_integration_status.dart';
import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../utils/route_matching.dart';

class OrchestratorController extends GetxController {
  final client = MqttServerClient('', 'iot_app_flutter');
  var connected = false.obs;
  var connectionState = "waiting".obs;
  var connectionError = "".obs;

  var integrationStatus = <IntegrationStatus>[].obs;

  @override
  void onInit() {
    super.onInit();
    print("Initializing OrchestratorController");

    // Listen to connection state changes and update accordingly
    connectionState.listen((state) {
      print("Connection state changed: $state");
      if (state == "connected") {
        connected.value = true;
      } else if (state == "disconnected") {
        connected.value = false;
      } else if (state == "waiting") {
        connected.value = false;
      } else if (state == "error") {
        connected.value = false;
      } else if (state == "connecting") {
        connected.value = false;
      } else {
        print("Unknown connection state: $state");
        connected.value = false;
      }
    });

    // Set up MQTT client
    client.setProtocolV311();
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onDisconnected = () {
      print('MQTT client disconnected');
      connectionState.value = "disconnected";
      _connect();
    };
    final connMess = MqttConnectMessage()
      .withClientIdentifier('iot_app_flutter')
      // .withWillTopic('/death') // If you set this you must set a will message
      // .withWillMessage('IoT App Disconnected') // If you set this you must set a will topic
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    // And finally, connect!
    // Moved to line 54, 90
  }

  Future<void> onConnect() async {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      handleClientUpdates(c);
    });
    client.subscribe('/#', MqttQos.atMostOnce);
    sendMessage("/orchestrator/getdata/status", "");
    sendMessage("/orchestrator/getdata/state", "");
  }

  Future<bool> connect(String connectionString) async {
    String ip = connectionString.split(":")[0];
    int port = int.parse(connectionString.split(":")[1]);
    client.server = ip;
    client.port = port;
    await _connect();
    return connectionState.value == "connected";
  }

  void handleClientUpdates(List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt = MqttPublishPayload.bytesToStringAsString(
      recMess.payload.message,
    );
    // print('::MESSAGE:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    handleMessage(c[0].topic, pt);
  }

  void sendMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  void handleMessage(String topic, String payload) {
    // print('Received message on topic: $topic with payload: $payload');
    if(topic == "/orchestrator/status"){
      Map<String, dynamic> map = jsonDecode(payload);
      List<IntegrationStatus> statuses = [];
      map.forEach((key, value) {
        value["id"] = key;
        statuses.add(IntegrationStatus.fromJson(value as Map<String, dynamic>));
      });
      integrationStatus.value = statuses;
      return;
    }
  }

  // Connection logic with retry mechanism
  Future<void> _connect({int maxRetries = 3, Duration retryDelay = const Duration(seconds: 2)}) async {
    if(connectionState.value == "connected"){
      client.disconnect();
      connectionState.value = "disconnected";
    }
    int attempt = 0;
    while (attempt < maxRetries) {
      attempt++;
      try {
        print('MQTT client connecting.... (attempt $attempt/$maxRetries)');
        connectionState.value = "connecting";
        await client.connect();

        if (client.connectionStatus?.state == MqttConnectionState.connected) {
          print('MQTT client connected');
          connectionState.value = "connected";
          
          // Set up subscriptions and such
          print('MQTT client connection process completed');
          await onConnect();
          return;
        } else {
          print('ERROR MQTT client connection failed - status is ${client.connectionStatus}');
          client.disconnect();
        }
      } on NoConnectionException catch (e) {
        print('MQTT client exception - $e');
        client.disconnect();
        connectionState.value = "error";
      } on SocketException catch (e) {
        print('MQTT socket exception - $e');
        client.disconnect();
        connectionState.value = "error";
      } catch (e) {
        print('Unexpected exception - $e');
        client.disconnect();
        connectionState.value = "error";
      }

      if (attempt < maxRetries) {
        print('Retrying in ${retryDelay.inSeconds} seconds...');
        await Future.delayed(retryDelay);
      } else {
        print('Max retry attempts reached. Giving up.');
        connected.value = false;
      }
    }
  }
}