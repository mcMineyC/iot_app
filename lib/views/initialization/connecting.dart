import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/homeScreen.dart';

import '../../controllers/orchestrator.dart';

class ConnectingView extends StatelessWidget {
  ConnectingView({Key? key, this.connectionString = ""}) : super(key: key);
  final String connectionString;
  final controller = Get.find<OrchestratorController>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    if(controller.connectionState.value == "waiting"){
      controller.connect(connectionString);
    }

    return Scaffold(
      body: Container(
        color: colors.surface,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GetX<OrchestratorController>(
            builder: (controller) {
              if(controller.connectionState.value == "connecting"){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: colors.primaryContainer,
                    ),
                    SizedBox(height: 16),
                    Text("Connecting...", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer)),
                  ],
                );
              } else if(controller.connectionState.value == "error"){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error, color: colors.error, size: 48),
                    SizedBox(height: 16),
                    Text("Connection Error", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer)),
                    SizedBox(height: 8),
                    Text(controller.connectionError.value, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colors.onPrimaryContainer)),
                  ],
                );
              } else if(controller.connectionState.value == "connected"){
                // Navigate to home screen after a short delay
                Future.delayed(Duration(seconds: 1), () => Get.offAll(Homescreen()));
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: colors.primaryContainer, size: 48),
                    SizedBox(height: 16),
                    Text("Connected!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer)),
                  ],
                );
              } else {
                // Fallback
                return Text("Unknown state: ${controller.connectionState.value}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer));
              }
            }
          ),
        ),
      ),
    );
  }
}
