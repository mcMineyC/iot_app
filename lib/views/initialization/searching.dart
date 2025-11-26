import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/initialization/connecting.dart';
import '../../controllers/mdns.dart';
import '../../controllers/orchestrator.dart';

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
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,12),
                      child: Text("Select an instance", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: colors.onPrimaryContainer)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: instances.length,
                        itemBuilder: (_, int index) =>
                          GestureDetector(
                            onTap: () {
                              Get.to(ConnectingView(
                                connectionString: instances[index].connectionString,
                              ));
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
                                        instances[index].connectionString,
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
                      )
                    ),
                  ],
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
