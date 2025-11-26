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
      body: Center(
        child: GetX<MdnsDiscoveryController>(
          builder: (controller) {
            if(controller.found.value.length > 0){
              List instances = controller.found.value;
              // List instanceWidgets = controller.found.value.map((i) => Text(
              //   "${i.ip}:${i.port} - (${i.name})"
              // )).toList(),
              return ListView.builder(
                itemCount: instances.length,
                itemBuilder: (_, int index) =>
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colors.primaryContainer,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${instances[index].name} - ${instances[index].ip}:${instances[index].port}",
                          style: TextStyle(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            var orchestrator = Get.find<OrchestratorController>();
                            orchestrator.connect(
                              "${instances[index].ip}:${instances[index].port}"
                            );
                          },
                          child: Text("Connect"),
                        ),
                      ],
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
    );
  }
}
