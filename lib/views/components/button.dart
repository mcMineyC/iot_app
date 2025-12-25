import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";

import "../../models/orchestrator_integration_status.dart";
import "../../utils/hetu_wrapper.dart";
import "../integrationComponents/generics.dart";
import "../../utils/snackbar.dart";

class IntegrationButton extends StatefulWidget {
  final String label;
  final String integrationId;
  final String evaluatorScript;
  final String outputTransformer;

  const IntegrationButton({
    Key? key,
    required this.label,
    required this.integrationId,
    required this.evaluatorScript,
    required this.outputTransformer,
  }) : super(key: key);

  @override
  _IntegrationButtonState createState() => _IntegrationButtonState();
}

class _IntegrationButtonState extends State<IntegrationButton> {
  late final OrchestratorController orchestrator;
  late final HetuWrapper hetu;
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

  @override
  void initState() {
    super.initState();
    orchestrator = Get.find<OrchestratorController>();
    hetu = Get.find<HetuWrapper>();
    ever(orchestrator.integrationStatus, (_) => updateOnlineStatus());
    updateOnlineStatus();
  }

  @override
  Widget build(BuildContext context) {
    return GenericIntegrationComponent(
      online: online,
      title: widget.label,
      child: FilledButton.tonalIcon(
        onPressed: () {
          hetu.executeTransformer(widget.outputTransformer, widget.integrationId, {"value": true});
        },
        label: Text(widget.label),
        icon: const Icon(Icons.handshake_rounded),
      ),
    );
  }
}