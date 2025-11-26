import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/orchestrator.dart';

class Homescreen extends StatelessWidget {
  final controller = Get.find<OrchestratorController>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        color: colors.surface,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GetX<OrchestratorController>(
            builder: (controller) {
              if(controller.connected.value){
                return Text("Connected to the orchestrator!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer));
              } else {
                return Text("Not connected.", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer));
              }
            }
          ),
        ),
      ),
    );
  }
}
