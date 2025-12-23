import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";

import "../integrationComponents/generics.dart";
import "../../utils/snackbar.dart";

import "dart:async";
import "dart:ui";
import "dart:convert";

class IntegrationSlider extends StatefulWidget {
  final String label;
  final String integrationId;
  final String actionPath;
  final String? evaluatorScript;
  final String? outputTransformer;
  final int debounceDelay = 300;

  IntegrationSlider({
    Key? key,
    required this.label,
    required this.integrationId,
    required this.actionPath,
    this.evaluatorScript,
    this.outputTransformer,
  }) : super(key: key);

  @override
  _IntegrationSliderState createState() => _IntegrationSliderState();
}

class _IntegrationSliderState extends State<IntegrationSlider> {
  late final OrchestratorController orchestrator;
  Timer? _debounceTimer;
  double _value = 0;
  bool changed = false;
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    orchestrator = Get.find<OrchestratorController>();
    ever(orchestrator.integrationStatus)
    ever(orchestrator.orchestratorState, (_) {
      if(!orchestrator.orchestratorState.containsKey(widget.integrationId) && enabled == false)
        return;
      print("\n\n\n\t\t\tSetting up value");
      var state = jsonDecode(orchestrator.orchestratorState[widget.integrationId]!["/lightState"]);
      var tempRange = jsonDecode(orchestrator.orchestratorState[widget.integrationId]!["/temperatureRange"]);
      int temp = state["color_temp"] ?? 4200;
      int min = tempRange["min"] ?? 0;
      int max = tempRange["max"] ?? 100;
      double val = ((temp - min) * (1 - 0)) / (max - min) + 0;
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {_value = val; enabled = true;}));
    });
  }

  void _onChanged(double value, BuildContext context) {
    setState(() => _value = value);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: widget.debounceDelay), () {
      try {
        Map<String, dynamic> temp = jsonDecode(orchestrator.orchestratorState[widget.integrationId]!["/temperatureRange"]);
        orchestrator.sendMessage(
          "/${widget.integrationId}${widget.actionPath}",
          lerpDouble(temp["min"] ?? 0, temp["max"] ?? 100, value)!.toInt().toString()
        );
      } catch (e) {
        rethrow;
        context.showSnackbar("Error: "+e.toString());
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericIntegrationComponent(
      title: widget.label,
      child: RotatedBox(
        quarterTurns: 3,
        child: Slider(
          year2023: false,
          value: _value,
          min: 0,
          max: 1,
          divisions: 100,
          onChanged: !enabled ? null : (double v) => _onChanged(v, context),
        ),
      ),
    );
  }
}
