import "package:get/get.dart";
import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class OrchestratorController extends GetxController {
  final client = MqttServerClient('', 'iot_app_flutter');
  var connected = false.obs;
  var connectionState = "waiting".obs;
  var connectionError = "".obs;
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
    print('::MESSAGE:: topic is <${c[0].topic}>, payload is <-- $pt -->');
  }

  void handleMessage(String topic, String payload) {
    print('Received message on topic: $topic with payload: $payload');
    // Here you can add logic to handle different topics and payloads
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
        await client.connect();

        if (client.connectionStatus?.state == MqttConnectionState.connected) {
          print('MQTT client connected');
          connectionState.value = "connected";
          
          // Set up subscriptions and such
          print('MQTT client connection process completed');
          client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
            handleClientUpdates(c);
          });
          client.subscribe('/#', MqttQos.atMostOnce);

          return;
        } else {
          print('ERROR MQTT client connection failed - status is ${client.connectionStatus}');
          client.disconnect();
        }
      } on NoConnectionException catch (e) {
        print('MQTT client exception - $e');
        connectionState.value = "error";
        client.disconnect();
      } on SocketException catch (e) {
        print('MQTT socket exception - $e');
        connectionState.value = "error";
        client.disconnect();
      } catch (e) {
        print('Unexpected exception - $e');
        client.disconnect();
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

typedef RouteHandler = dynamic Function(Map<String, String> params);

Map<String, RouteHandler> _routes = {};

void registerRoute(String pattern, RouteHandler handler) {
  // Precompile pattern into regex for faster matching
  final parts = pattern.split('/');
  final regexPattern = parts.map((part) {
    if (part.startsWith(':')) {
      return '([^\\/]+)';
    }
    return part;
  }).join('\\/');
  
  final regex = RegExp('^/$regexPattern\$');
  _routes[pattern] = (params) => handler(params);
}

dynamic matchRoute(String path, {bool caseSensitive = false}) {
  // Normalize path: remove leading/trailing slashes and ensure single leading slash for matching
  final normalizedPath = path.replaceAll(RegExp(r'^/+|/+$'), '');
  final requestPath = '/$normalizedPath';
  
  for (var entry in _routes.entries) {
    final pattern = entry.key;
    final handler = entry.value;
    
    // Quick string comparison first (normalize the pattern similarly)
    final normalizedPattern = pattern.replaceAll(RegExp(r'^/+|/+$'), '');
    if (!caseSensitive && !pattern.contains(':') && normalizedPattern == normalizedPath) {
      return handler(<String, String>{});
    }
        
    try {
      // Build regex from pattern, escaping static parts and converting :param to capture groups
      final patternParts = normalizedPattern.split('/');
      final regexPattern = patternParts.map((part) {
        if (part.startsWith(':')) {
          return '([^/]+)';
        }
        return RegExp.escape(part);
      }).join('/');
      
      final regex = RegExp('^/$regexPattern\$');
      final match = regex.firstMatch(requestPath);
      if (match == null) continue;
      
      // Extract parameters
      final params = <String, String>{};
      for (var i = 0; i < patternParts.length; i++) {
        final part = patternParts[i];
        if (part.startsWith(':')) {
          params[part.substring(1)] = match.group(i + 1)!;
        }
      }
      
      return handler(params);
    } catch (_) {
      continue;
    }
  }
  
  throw Exception('Route not found');
}
