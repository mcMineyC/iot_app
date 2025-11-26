import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/homeScreen.dart';
import 'package:iot_app/views/initialization/searching.dart';

import '../../controllers/orchestrator.dart';
import '../../controllers/preferences.dart';
import 'connecting.dart';

class StartingView extends StatelessWidget {
  final controller = Get.find<PreferencesController>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(controller.cachedConnectionString.value.isNotEmpty){
        print("Auto-connecting...");
        Get.offAll(ConnectingView(
          connectionString: controller.cachedConnectionString.value,
        ), routeName: "/connecting");
      }else{
        print("No cached connection string found, searching...");
        Get.offAll(SearchingView(), routeName: "/searching");
      }
    });
    return Scaffold(
      body: Container(
        color: colors.surface,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator()
        ),
      ),
    );
  }
}
