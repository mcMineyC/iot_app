import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/settings/schema.dart';

import '../../controllers/orchestrator.dart';

class IntegrationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return GetX<OrchestratorController>(
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
                  bool isRunning = status.status.toLowerCase() == 'running';
                  bool isInging = status.status.toLowerCase() == 'starting';
                  return ListTile(
                    leading: !isInging ? Icon(
                            isRunning ? Icons.check_circle : Icons.error,
                            color: isRunning ? Colors.green : Colors.red,
                          ) : CircularProgressIndicator(),
                    title: Text(
                      status.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer),
                    ),
                    subtitle: Text(
                      'Status: ${status.status}\nError: ${status.error}$description',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colors.onPrimaryContainer),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle menu item selection
                        print('Selected: $value');
                        switch(value){
                          case 'start':
                            controller.startIntegration(status.id);
                            break;
                          case 'stop':
                            controller.stopIntegration(status.id);
                            break;
                          case 'schema':
                            Get.to(IntegrationSchemaView(integrationKey: status.id));
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        if(isRunning || isInging) PopupMenuItem(
                          value: 'stop',
                          child: Text('Stop'),
                          // enabled: !isInging,
                        ),
                        if(!isRunning && ! isInging) const PopupMenuItem(
                          value: 'start',
                          child: Text('Start'),
                          
                        ),
                        const PopupMenuItem(
                          value: 'schema',
                          child: Text('View schema'),
                        ),
                        // const PopupMenuItem(  // TODO: Add details view
                        //   value: 'details',
                        //   child: Text('View details'),
                        // ),
                      ],
                    ),
                    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {
                    //         if(isRunning){
                    //           controller.stopIntegration(status.id);
                    //         }else{
                    //           controller.startIntegration(status.id);
                    //         }
                    //       }, 
                    //       icon: isRunning ? Icon(Icons.stop_circle_rounded) : Icon(Icons.play_arrow_rounded),
                    //     ),
                    //     SizedBox(width: 6),
                        
                    //   ],
                    // ),
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
    );
  }
}