import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/orchestrator.dart';

class Homescreen extends StatelessWidget {
  final controller = Get.find<OrchestratorController>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colors.surface,
        backgroundColor: colors.surface,
        title: Text("Home"),
        leading: Builder(
          builder: (context) {
            return IconButton(icon: Icon(Icons.menu_rounded), color: colors.onSurface, onPressed: () => Scaffold.of(context).openDrawer());
          }
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: colors.primaryContainer,
              ),
              child: Text("Menu", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: colors.onPrimaryContainer)),
            ),
          ],
        ),
      ),
      body: Container(
        color: colors.surface,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GetX<OrchestratorController>(
            builder: (controller) {
              if(controller.connected.value){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    child: Text(
                    "Integration status",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.onPrimaryContainer,
                    ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                    children: controller.integrationStatus.map((status) {
                      final description = status.error != 0 ? '\nDescription: ${status.errorDescription}' : '';
                      return ListTile(
                        title: Text(
                          status.name,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer),
                        ),
                        subtitle: Text(
                          'Status: ${status.status}\nError: ${status.error}$description',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colors.onPrimaryContainer),
                        ),
                        trailing: Icon(
                          status.status.toLowerCase() == 'running' ? Icons.check_circle : Icons.error,
                          color: status.status.toLowerCase() == 'running' ? Colors.green : Colors.red,
                        ),
                      );
                    }).toList(),
                    ),
                  ),
                  ],
                );
                // return Text("Connected to the orchestrator!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer));
              } else {
                return Text("Not connected.", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer));
              }
            }
          ),
        ),
      ),
    );
  }
}
