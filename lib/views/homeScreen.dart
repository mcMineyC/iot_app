import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/utils/constants.dart';
import 'components/generics.dart';
import "../utils/snackbar.dart";

import 'components/button.dart';
import 'components/slider.dart';
import "settings/integrationList.dart";
import '../../controllers/orchestrator.dart';

class Homescreen extends StatelessWidget {
  final controller = Get.find<OrchestratorController>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Center(
      child: Obx(() => !controller.connected.value ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Not connected to Orchestrator",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: colors.onErrorContainer)),
          SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              controller.reconnect();
            },
            icon: Icon(Icons.refresh_rounded),
            label: Text("Reconnect"),
          )
        ],
      )
        : ListView(
          children: kDashboardConfig.map((e) => UiDefinitionToWidget(e)).toList(),
          // children: [
          //   GenericIntegrationComponent(
          //     title: "Hello World",
          //     child: FilledButton.tonalIcon(
          //       onPressed: (){context.showSnackbar("Hello World!");},
          //       label: Text("Example"),
          //       icon: Icon(Icons.handshake_rounded),
          //     )
          //   )
          // ]
        )
      ),
    );
  }
}
