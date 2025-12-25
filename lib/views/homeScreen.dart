import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/utils/constants.dart';
import '../views/integrationComponents/generics.dart';
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
      child: Obx(() => !controller.connected.value ? Text("Not connected to Orchestrator",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: colors.onErrorContainer))
        : ListView(
          children: kDashboardConfig.map((e) => switch(e.type){
            IntegrationUiType.button => IntegrationButton(
              label: e.label,
              integrationId: e.integrationId,
              actionPath: e.dataPath,
              evaluatorScript: e.evaluatorScript,
              outputTransformer: e.outputTransformer,
            ),
            IntegrationUiType.slider => IntegrationSlider(
              label: e.label,
              integrationId: e.integrationId,
              actionPath: e.dataPath,
              evaluatorScript: e.evaluatorScript,
              outputTransformer: e.outputTransformer,
            ),
            _ => SizedBox.shrink(),
          }).toList(),
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
