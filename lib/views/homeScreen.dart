import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "../views/settings/instanceList.dart";
import '../../controllers/orchestrator.dart';

class Homescreen extends StatelessWidget {
  final controller = Get.find<OrchestratorController>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Center(
      child: Obx(() => !controller.connected.value ? Text("Not connected to Orchestrator",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: colors.onErrorContainer))
      : InstanceList()
      ),
    );
  }
}
