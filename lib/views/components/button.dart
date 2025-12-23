import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";

import "../integrationComponents/generics.dart";
import "../../utils/snackbar.dart";

class IntegrationButton extends StatelessWidget {
  final String label;
  final String integrationId;
  final String actionPath;
  final String? evaluatorScript;
  final String? outputTransformer;

  IntegrationButton({required this.label, required this.integrationId, required this.actionPath, this.evaluatorScript, this.outputTransformer});
  @override
  Widget build(BuildContext context) {
    OrchestratorController orchestrator = Get.find<OrchestratorController>();
    return GenericIntegrationComponent(
      title: label,
      child: FilledButton.tonalIcon(
        onPressed: (){
          context.showSnackbar("Hello World!");
          orchestrator.sendMessage("/${integrationId}${actionPath}", "");
        },
        label: Text("Example"),
        icon: Icon(Icons.handshake_rounded),
      )
    );
  }
}