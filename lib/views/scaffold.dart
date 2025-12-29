import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "settings/integrationList.dart";
import '../../controllers/orchestrator.dart';

class ScaffoldWidget extends StatelessWidget {
  final controller = Get.find<OrchestratorController>(); // May add disconnect support eventually

  final Widget child;
  ScaffoldWidget({required this.child, super.key});

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
      drawer: NavigationDrawer(
        onDestinationSelected: (value) {
          switch (value) {
            case 0:
              Get.offAllNamed('/home');
              break;
            case 1:
              Get.toNamed('/integrationList');
              break;
            case 2:
              Get.toNamed('/settings');
              break;
          }
        },
        selectedIndex: switch (Get.routing.current) {  
          '/home' => 0,
          '/integrationList' => 1,
          '/settings' => 2,
          _ => null,
        },
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: colors.primaryContainer,
            ),
            child: Text("Menu", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: colors.onPrimaryContainer)),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.home_rounded),
            label: Text("Home"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.info_outline_rounded),
            label: Text("Integration Status"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_rounded),
            label: Text("Settings"),
          ),
          // ListTile(
          //   leading: Icon(Icons.settings, color: colors.onSurface),
          //   title: Text('Settings', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onSurface)),
          //   onTap: () {
          //     Get.to(IntegrationList());
          //   },
          // ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: colors.primaryContainer,
      //         ),
      //         child: Text("Menu", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: colors.onPrimaryContainer)),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.settings, color: colors.onSurface),
      //         title: Text('Settings', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onSurface)),
      //         onTap: () {
      //           Navigator.pushNamed(context, '/settings');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        color: colors.surface,
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => !controller.connected.value ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Not connected to Orchestrator",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: colors.onErrorContainer)),
              SizedBox(height: 16),
              controller.connectionState == "errorFinal" ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: () {
                      Get.offNamed("/searching");
                    },
                    label: Text("Discover"),
                    icon: Icon(Icons.search_rounded),
                  ),
                  SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      controller.reconnect();
                    },
                    label: Text("Retry"),
                    icon: Icon(Icons.refresh_rounded),
                  ),
                ]
              ) : SizedBox.shrink(),
            ],
          ),
        ) : child,
      )),
    );
  }
}