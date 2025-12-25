import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";
import "package:iot_app/models/orchestrator_integration_status.dart";

import "../../utils/hetu_wrapper.dart";
import "../integrationComponents/generics.dart";
import "../../utils/snackbar.dart";

import "dart:async";
import "dart:ui";
import "dart:convert";

// evaluator object format
// min: int
// max: int
// step: int
// value: int

// output transformer format
// min: int
// max: int
// step: int
// value: int

class IntegrationSlider extends StatefulWidget {
  final String label;
  final String integrationId;
  final String evaluatorScript;
  final String outputTransformer;
  final int debounceDelay = 300;

  IntegrationSlider({
    Key? key,
    required this.label,
    required this.integrationId,
    required this.evaluatorScript,
    required this.outputTransformer,
  }) : super(key: key);

  @override
  _IntegrationSliderState createState() => _IntegrationSliderState();
}

class _IntegrationSliderState extends State<IntegrationSlider> {
  late final OrchestratorController orchestrator;
  late final HetuWrapper hetu;
  int min = 0;
  int max = 100;
  int value = 0;
  Timer? _debounceTimer;
  double _value = 0;
  bool setupChangeListener = false;
  bool changed = false;
  bool enabled = false;
  bool online = false;

  void updateOnlineStatus(){
    print("\n\n\n\tChecking online status for integration ${widget.integrationId}");
    if(!orchestrator.integrationStatus.containsKey(widget.integrationId)){
      print("\t------> Integration status not found!");
      return;
    }
    IntegrationStatus status = orchestrator.integrationStatus[widget.integrationId]!;
    if(status.status == "running") {
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

  void updateIntegrationState(){
    if(!orchestrator.orchestratorState.containsKey(widget.integrationId))
      return;
    var state = orchestrator.orchestratorState[widget.integrationId]!;
    print("\n\n\n\t\t\tSetting up value");
    print("HETU EVALUATOR\n\n\n");
    try {
      var result = hetu.executeEvaluator(
        widget.evaluatorScript, widget.integrationId, state as Map<String, dynamic>);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {min = result["min"]; max = result["max"]; value = result["value"]; _value = value.toDouble(); enabled = true;}));
    
    } catch (e) {
      print("Error in evaluator script for integration ${widget.integrationId}: "+e.toString());
      // rethrow;
      WidgetsBinding.instance.addPostFrameCallback((_) {context.showSnackbar( "Error in evaluator script for integration ${widget.integrationId}: "+e.toString());});
      return;
    }
  }

  void checkForIntegrationData(){
    if(setupChangeListener)
      return;
    if(!orchestrator.haveIntegrationData.containsKey(widget.integrationId))
      return;
    setupChangeListener = true;
    ever(orchestrator.orchestratorState[widget.integrationId]!, (_) {
      updateIntegrationState();
    });
    updateIntegrationState();
  }
  @override
  void initState() {
    super.initState();
    orchestrator = Get.find<OrchestratorController>();
    hetu = Get.find<HetuWrapper>();

    ever(orchestrator.integrationStatus, (_) {
      updateOnlineStatus();
    });
    ever(orchestrator.haveIntegrationData, (_) {
      checkForIntegrationData();
    });

    checkForIntegrationData();    
    
    updateOnlineStatus();
  }

  void _onChanged(double value, BuildContext context) {
    setState(() => _value = value);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: widget.debounceDelay), () {
      hetu.executeTransformer(widget.outputTransformer, widget.integrationId, {"min": min, "max": max, "value": _value.toInt()});
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
      online: online,
      title: widget.label,
      child: RotatedBox(
        quarterTurns: 3,
        child: Slider(
          year2023: false,
          value: _value,
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: 100,
          onChanged: !enabled ? null : (double v) => _onChanged(v, context),
        ),
      ),
    );
  }
}
