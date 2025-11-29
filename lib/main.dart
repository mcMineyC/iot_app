import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/initialization/starting.dart';
import "package:shared_preferences/shared_preferences.dart";

import "controllers/preferences.dart";
import 'controllers/mdns.dart';
import 'controllers/orchestrator.dart';

import 'views/homeScreen.dart';
import "views/initialization/searching.dart";
import 'views/scaffold.dart';
import 'views/settings/integrationList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  Get.put(sp);

  if(sp.containsKey("cachedConnectionString")){
    print("Found cached connection string: \"${sp.getString("cachedConnectionString")}\"!!!");
  }

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
      title: 'IoT App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.dark),
        fontFamily: 'JetBrainsMono',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
      home: StartingView(),
      getPages: [
        GetPage(name: '/starting', page: () => StartingView()),
        GetPage(name: '/searching', page: () => SearchingView()),
        GetPage(
          name: '/home',
          page: () => ScaffoldWidget(child: Homescreen()),
        ),
        GetPage(
          name: '/integrationList',
          page: () => ScaffoldWidget(child: IntegrationList()),
        )
      ],
    );
  }
}