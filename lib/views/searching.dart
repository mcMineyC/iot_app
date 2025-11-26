import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mdns.dart';
import '../controllers/orchestrator.dart';

class SearchingView extends StatelessWidget {
  final controller = Get.find<MdnsDiscoveryController>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    // So we don't spam queries when we rebuild
    if(!controller.searching)
      controller.findServices();

    return Scaffold(
      body: Container(
        color: colors.surface,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GetX<MdnsDiscoveryController>(
            builder: (controller) {
              if(controller.found.value.isNotEmpty){
                List instances = controller.found.value;
                // List instanceWidgets = controller.found.value.map((i) => Text(
                //   "${i.ip}:${i.port} - (${i.name})"
                // )).toList(),
                return ListView.builder(
                  itemCount: instances.length,
                  itemBuilder: (_, int index) =>
                    GestureDetector(
                      onTap: () {
                        var orchestrator = Get.find<OrchestratorController>();
                        orchestrator.connect(
                          "${instances[index].ip}:${instances[index].port}"
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: colors.primaryContainer,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  instances[index].name,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: colors.onPrimaryContainer),
                                ),
                                Text(
                                  "${instances[index].ip}:${instances[index].port}",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colors.onPrimaryContainer),
                                ),
                              ]
                            ),
                            Icon(Icons.chevron_right_rounded, size: 32, color: colors.onPrimaryContainer),
                            // IconButton(
                            //   onPressed: () {
                            //     var orchestrator = Get.find<OrchestratorController>();
                            //     orchestrator.connect(
                            //       "${instances[index].ip}:${instances[index].port}"
                            //     );
                            //   },
                            //   icon: Icon(Icons.chevron_right_rounded),
                            // ),
                          ],
                        ),
                      ),
                    ),
                );
                // Future.delayed(Duration(milliseconds: 500), () {
                //   var orchestrator = Get.find<OrchestratorController>();
                //   orchestrator.connect(
                //     "${instances[0].ip}:${instances[0].port}"
                //   );
                // });
              }else{
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Text("Searching for orchestrators")
                  ]
                );
              }
            }
          ),
        ),
      ),
    );
  }
}
