import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";

import "../../models/orchestrator_integration_status.dart";
import "../../utils/eval_wrapper.dart";
import "../../utils/icon_map.dart";
import "generics.dart";
import "../../utils/snackbar.dart";

class IntegrationMediaPlayer extends StatefulWidget {
  final String label;
  final String integrationId;

  const IntegrationMediaPlayer({
    Key? key,
    required this.label,
    required this.integrationId,
  }) : super(key: key);

  @override
  _IntegrationMediaPlayerState createState() => _IntegrationMediaPlayerState();
}

class _IntegrationMediaPlayerState extends State<IntegrationMediaPlayer> {
  late final OrchestratorController orchestrator;
  bool online = false;
  bool enabled = false;
  bool setupChangeListener = false;
  List<Worker> _subscriptions = [];

  void updateIntegrationState() {
    if (!orchestrator.orchestratorState.containsKey(widget.integrationId))
      return;
    var state = orchestrator.orchestratorState[widget.integrationId]!;
    try {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => setState(() {
          enabled = true;
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
    _subscriptions.add(ever(orchestrator.orchestratorState[widget.integrationId]!, (_) {
      updateIntegrationState();
    }));
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
    return LayoutBuilder(builder: (context, constraints) {
      Widget player = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 360),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: GenericIntegrationComponent(
            online: online,
            padding: EdgeInsets.all(0),
            title: widget.label,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    Icons.music_note,
                    color: Colors.grey.shade800,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // If available width is less than 264, show a horizontal scroll with 320px child
      if (constraints.maxWidth < 264) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(width: 320, child: player),
        );
      }

      // Otherwise size the child to fit the parent but not exceed 360
      double width = constraints.maxWidth;
      if (width > 360) width = 360;

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: width, child: player),
        ],
      );
    });
  }
}
