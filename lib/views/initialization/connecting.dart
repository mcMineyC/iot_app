import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/homeScreen.dart';

import '../../controllers/orchestrator.dart';
import '../../controllers/preferences.dart';

class ConnectingView extends StatelessWidget {
  ConnectingView({Key? key, this.connectionString = ""}) : super(key: key);
  final String connectionString;
  final controller = Get.find<OrchestratorController>();
  final prefsController = Get.find<PreferencesController>();

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
              if(controller.connectionState.value == "connecting" || controller.connectionState.value == "disconnected"){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Connecting", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer)),
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
                    // SizedBox(height: 8),
                    FilledButton.tonalIcon(
                      onPressed: () {
                        controller.connect(connectionString);
                      },
                      label: Text("Retry"),
                      icon: Icon(Icons.refresh_rounded),
                    ),
                  ],
                );
              } else if(controller.connectionState.value == "connected"){
                // Navigate to home screen after a short delay
                if(prefsController.cachedConnectionString.value.isEmpty){
                  Future.delayed(Duration(seconds: 1), () => Get.offAllNamed('/home'));

                  // Cache the connection string to auto-connect next time
                  Get.find<PreferencesController>().cachedConnectionString.value = connectionString;
                }else{
                  WidgetsBinding.instance.addPostFrameCallback((_) => Get.offAllNamed('/home'));
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: colors.primary, size: 48),
                    SizedBox(height: 16),
                    Text("Connected!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onSurface)),
                  ],
                );
              } else {
                // Fallback
                return CircularProgressIndicator();
                // return Text("Unknown state: ${controller.connectionState.value}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer));
              }
            }
          ),
        ),
      ),
    );
  }
}
