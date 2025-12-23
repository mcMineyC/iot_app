import 'dart:convert';

import "package:get/get.dart";
import 'package:iot_app/models/orchestrator_integration_status.dart';
import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../models/integrationconfig.dart';
import '../models/integrationschema.dart';
import '../utils/route_matching.dart';

class OrchestratorController extends GetxController {
  final client = MqttServerClient('', 'iot_app_flutter');
  var connected = false.obs;
  var connectionState = "".obs;
  var connectionError = "".obs;
  var hasConnected = false;

  RxMap<String, IntegrationStatus> integrationStatus = RxMap<String, IntegrationStatus>({});
  RxMap<String, RxMap<String, dynamic>> orchestratorState = <String, RxMap<String, dynamic>>{}.obs;
  RxMap<String, List<IntegrationSchema>> integrationSchemas = <String, List<IntegrationSchema>>{}.obs;
  RxMap<String, IntegrationConfig> enabledIntegrations = <String, IntegrationConfig>{}.obs;

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
      if(!hasConnected)
        return;
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
    sendMessage("/orchestrator/getdata/fullState", "");
    sendMessage("/orchestrator/getdata/enabledIntegrations", "");
  }

  Future<bool> connect(String connectionString) async {
    String ip = connectionString.split(":")[0];
    int port = int.parse(connectionString.split(":")[1]);
    client.server = ip;
    client.port = port;
    await _connect();
    hasConnected = true;
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
    print('::MESSAGE:: topic is <$topic>, payload is <-- $payload -->');
    // print('Received message on topic: $topic with payload: $payload');
    if(topic == "/orchestrator/status"){
      Map<String, dynamic> map = jsonDecode(payload);
      List<IntegrationStatus> statuses = [];
      map.forEach((key, value) {
        value["id"] = key;
        integrationStatus[key] = IntegrationStatus.fromJson(value as Map<String, dynamic>);
      });
      // integrationStatus.value = statuses;
      return;
    }else if(topic.startsWith("/orchestrator/status/")){
      String integrationId = topic.split("/").last;
      Map<String, dynamic> map = jsonDecode(payload);
      map["id"] = integrationId;
      IntegrationStatus updatedStatus = IntegrationStatus.fromJson(map);
      integrationStatus[integrationId] = updatedStatus;
      // int index = integrationStatus.indexWhere((status) => status.id == integrationId);
      // if(index != -1){
      //   integrationStatus[index] = updatedStatus;
      // }else{
      //   integrationStatus.add(updatedStatus);
      // }
      return;
    }else if(topic == "/orchestrator/state"){
      Map<String, dynamic> map = jsonDecode(payload);
      print("Updating orchestrator state with keys: ${map.keys.toList()}");
      map.forEach((key, value) {
        orchestratorState[key] = RxMap<String, dynamic>.from(value as Map<String, dynamic>);
      });
      return;
    }else if(topic == "/orchestrator/schemas"){
      Map<String, List<IntegrationSchema>> schemas = {};
      Map<String, dynamic> map = jsonDecode(payload);
      map.forEach((key, value) {
        List<IntegrationSchema> schemaList = [];
        for(var item in value as List){
          schemaList.add(IntegrationSchema.fromJson(item as Map<String, dynamic>));
        }
        schemas[key] = schemaList;
      });
      print("Received integration schemas for keys: ${schemas}");
      integrationSchemas.value = schemas;
    }else if(topic == "/orchestrator/enabledIntegrations"){
      Map<String, dynamic> map = jsonDecode(payload);
      Map<String, IntegrationConfig> enabledIntegrations = {};
      map.forEach((key, value) {
        enabledIntegrations[key] = IntegrationConfig.fromJson(value as Map<String, dynamic?>);
      });
      this.enabledIntegrations.value = enabledIntegrations;
      // print("Enabled integrations: $enabledIntegrations");
    }
  }

  void startIntegration(String integrationId) {
    sendMessage("/orchestrator/integration/start", integrationId);
  }
  void stopIntegration(String integrationId) {
    sendMessage("/orchestrator/integration/$integrationId/stop", "");
  }

  // Connection logic with retry mechanism
  Future<void> _connect({int maxRetries = 3, Duration retryDelay = const Duration(seconds: 2)}) async {
    if(connectionState.value == "connected"){
      client.disconnect();
      connectionState.value = "disconnected";
    }
    print("\t\tStarting connection process...");
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
        return;
      }
    }
  }
}
