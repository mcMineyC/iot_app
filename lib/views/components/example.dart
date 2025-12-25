import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";

import "../../models/orchestrator_integration_status.dart";
import "../../utils/eval_wrapper.dart";
import "../../utils/icon_map.dart";
import "generics.dart";
import "../../utils/snackbar.dart";

class integrationComponent extends StatefulWidget {
  final String label;
  final String integrationId;
  final String evaluatorScript;
  final String outputTransformer;

  const integrationComponent({
    Key? key,
    required this.label,
    required this.integrationId,
    required this.evaluatorScript,
    required this.outputTransformer,
  }) : super(key: key);

  @override
  _integrationComponentState createState() => _integrationComponentState();
}

class _integrationComponentState extends State<integrationComponent> {
  late final OrchestratorController orchestrator;
  late final EvalWrapper hetu;
  bool online = false;
  bool enabled = false;
  bool setupChangeListener = false;

  // Add additional properties here to be filled by the evaluator

  void updateIntegrationState() {
    if (!orchestrator.orchestratorState.containsKey(widget.integrationId))
      return;
    var state = orchestrator.orchestratorState[widget.integrationId]!;
    try {
      var result = hetu.executeEvaluator(
        widget.evaluatorScript,
        widget.integrationId,
        state as Map<String, dynamic>,
      );
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => setState(() {
          enabled = true;
          // Fill widget properties from result here
        }),
      );
    } catch (e) {
      print(
        "Error in evaluator script for integration ${widget.integrationId}: " +
            e.toString(),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.showSnackbar(
          "Error in evaluator script for integration ${widget.integrationId}: " +
              e.toString(),
        );
      });
    }
  }

  void checkForIntegrationData() {
    if (setupChangeListener) return;
    if (!orchestrator.haveIntegrationData.containsKey(widget.integrationId))
      return;
    setupChangeListener = true;
    ever(orchestrator.orchestratorState[widget.integrationId]!, (_) {
      updateIntegrationState();
    });
    updateIntegrationState();
  }

  void updateOnlineStatus() {
    // print(
      // "\n\n\n\tChecking online status for integration ${widget.integrationId}",
    // );
    if (!orchestrator.integrationStatus.containsKey(widget.integrationId)) {
      // print("\t------> Integration status not found!");
      return;
    }
    IntegrationStatus status =
        orchestrator.integrationStatus[widget.integrationId]!;
    if (status.status == "running") {
      setState(() {
        // print("\t-----> Integration ${widget.integrationId} is online");
        online = true;
      });
    } else {
      setState(() {
        // print("\t-----> Integration ${widget.integrationId} is offline");
        online = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    orchestrator = Get.find<OrchestratorController>();
    hetu = Get.find<EvalWrapper>();
    ever(orchestrator.integrationStatus, (_) => updateOnlineStatus()); // Watch for integration to be online/offline
    ever(orchestrator.haveIntegrationData, (_) => checkForIntegrationData()); // Watch for us to have integration data
    checkForIntegrationData(); // Immediate check for data
    updateOnlineStatus(); // Immediate check for online
  }

  @override
  Widget build(BuildContext context) {
    return GenericIntegrationComponent(
      online: online,
      title: widget.label,
      child: FilledButton.tonalIcon(
        onPressed: !enabled
            ? null
            : () {
                hetu.executeTransformer(
                  widget.outputTransformer,
                  widget.integrationId,
                  {"value": true}, // Pass any state from the widget here
                );
              },
        label: const Text("Execute"),
        // label: Text(text), // Example of additional property usage
        icon: Icon(iconMap["handshake_rounded"]), // Looks up icon from iconMap in icon_map.dart
      ),
    );
  }
}
