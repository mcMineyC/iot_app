import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/controllers/preferences.dart';
import 'package:iot_app/utils/constants.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          elevation: 1,
          child: ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("App Version"),
            trailing: Text(kVersionString, style: Theme.of(context).textTheme.bodyMedium),
          )
        ),
        Card(
          elevation: 1,
          child: ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("Delete connection"),
            trailing: IconButton.filled(
                onPressed: () {
                  Get.find<PreferencesController>().cachedConnectionString.value = "";
                  Get.offAllNamed('/searching');
                },
                icon: Icon(Icons.delete_forever_rounded),
                color: Theme.of(context).colorScheme.error,

              ),
          )
        )
      ],
    );
  }
}