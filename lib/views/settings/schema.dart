import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../controllers/orchestrator.dart";

class IntegrationSchemaView extends StatelessWidget {
  final String integrationKey;

  IntegrationSchemaView({required this.integrationKey, super.key});

  @override
  Widget build(BuildContext context) {
    final orchestratorController = Get.find<OrchestratorController>();
    var providingIntegration = orchestratorController.enabledIntegrations[integrationKey]?.integrationName ?? "";
    final schemas = orchestratorController.integrationSchemas[providingIntegration] ?? [];
    print("Schemas for $integrationKey (provided by $providingIntegration): $schemas");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Text("Schema for $integrationKey ($providingIntegration)"),
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: schemas.length > 0 ? ListView.builder(
        itemCount: schemas.length,
        itemBuilder: (context, index) {
          final schema = schemas[index];
          return ListTile(
            title: Text(schema.path),
            subtitle: Text("Type: ${schema.type}\nFetchable: ${schema.fetchable}"),
            trailing: 
            schema.type == "data" ? IconButton(
              icon: Icon(Icons.info_outline_rounded),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      title: Text(schema.path),
                      content: Obx(() => Text(
                        orchestratorController.orchestratorState[integrationKey] != null ?
                        "Current Data: ${JsonEncoder.withIndent('  ').convert(orchestratorController.orchestratorState[integrationKey]![schema.path] ?? "{}")}" :
                        "No data received yet.",
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      )),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(null),
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              }) :
              IconButton( // Command type
              icon: Icon(Icons.send_rounded),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController textController = TextEditingController();
                    return AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      title: Text("Send data to ${schema.path}"),
                      content: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: "Enter data to send",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(null),
                          child: Text("Close"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(textController.text);
                          },
                          child: Text("Send"),
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    // Handle any actions after closing the dialog if necessary
                    orchestratorController.sendMessage("/${integrationKey}${schema.path}", value);
                  }
                });
              },
            ),
          );
        },
      ) : Center(child: Text("No schema available.")),
    );
  }
}