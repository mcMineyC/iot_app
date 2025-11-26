import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:shared_preferences/shared_preferences.dart";

import "controllers/preferences.dart";
import 'controllers/mdns.dart';
import 'controllers/orchestrator.dart';

import "views/searching.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  Get.put(sp);

  var prefsController = PreferencesController();
  await prefsController.restoreFromSp();
  Get.put(prefsController);

  var mdnsController = MdnsDiscoveryController();
  await mdnsController.init();
  Get.put(mdnsController);
  Get.put(OrchestratorController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.dark),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
      home: SearchingView(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    OrchestratorController controller = Get.find<OrchestratorController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Text('Connection Status: ${controller.connectionState.value}')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.connect("localhost:1883");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
