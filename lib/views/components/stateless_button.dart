import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";

import "../../models/orchestrator_integration_status.dart";
import "../../utils/eval_wrapper.dart";
import "../../utils/icon_map.dart";
import "generics.dart";
import "../../utils/snackbar.dart";

class IntegrationStatelessButton extends StatefulWidget {
  final String label;
  final String integrationId;
  final String evaluatorScript;
  final String outputTransformer;

  const IntegrationStatelessButton({
    Key? key,
    required this.label,
    required this.integrationId,
    required this.evaluatorScript,
    required this.outputTransformer,
  }) : super(key: key);

  @override
  _IntegrationStatelessButtonState createState() => _IntegrationStatelessButtonState();
}

class _IntegrationStatelessButtonState extends State<IntegrationStatelessButton> {
  late final OrchestratorController orchestrator;
  late final EvalWrapper hetu;
  bool online = false;
  bool enabled = false;
  String icon = "handshake_rounded";
  String text = "Execute";
  bool setupChangeListener = false;
  List<Worker> _subscriptions = [];

  void updateIntegrationState() {
    try {
      var result = hetu.executeEvaluator(
        widget.evaluatorScript,
        widget.integrationId,
        {"test": true} as Map<String, dynamic>, // empty enough state for stateless button
        // we just need the config from the evaluator
      );
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => setState(() {
          enabled = true;
          icon = result['icon'] ?? "handshake_rounded";
          text = result['text'] ?? widget.label;
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
    setupChangeListener = true;
    updateIntegrationState();
  }

  void updateOnlineStatus() {
    print(
      "\n\n\n\tChecking online status for integration ${widget.integrationId}",
    );
    if (!orchestrator.integrationStatus.containsKey(widget.integrationId)) {
      print("\t------> Integration status not found!");
      return;
    }
    IntegrationStatus status =
        orchestrator.integrationStatus[widget.integrationId]!;
    if (status.status == "running") {
      setState(() {
        print("\t-----> Integration ${widget.integrationId} is online");
        online = true;
      });
    } else {
      setState(() {
        print("\t-----> Integration ${widget.integrationId} is offline");
        online = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    orchestrator = Get.find<OrchestratorController>();
    hetu = Get.find<EvalWrapper>();
    _subscriptions.add(ever(orchestrator.integrationStatus, (_) => updateOnlineStatus()));
    _subscriptions.add(ever(orchestrator.haveIntegrationData, (_) => checkForIntegrationData()));
    checkForIntegrationData();
    updateOnlineStatus();
  }

  @override
  void dispose() {
    for (var subscription in _subscriptions) {
      subscription.dispose();
    }
    super.dispose();
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
                  {"value": true}, // For button we don't have state to convey
                );
              },
        label: Text(text),
        icon: Icon(iconMap[icon]),
      ),
    );
  }
}
