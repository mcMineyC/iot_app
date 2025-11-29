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
          );
        },
      ) : Center(child: Text("No schema available.")),
    );
  }
}