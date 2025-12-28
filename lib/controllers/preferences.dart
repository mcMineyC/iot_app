import "dart:convert";

import "package:get/get.dart";
import "package:iot_app/utils/constants.dart";
import "package:iot_app/views/components/generics.dart";
import "package:shared_preferences/shared_preferences.dart";

class PreferencesController extends GetxController {
  final SharedPreferences sp = Get.find<SharedPreferences>();
  var ready = false.obs;

  RxString cachedConnectionString = "".obs;
  RxList<dynamic> dashboardConfiguration = [].obs;
  String get dashboardConfigSerialized => serializeDashboardConfig(dashboardConfiguration);
  set dashboardConfigSerialized(String jsonString) {
    dashboardConfiguration.value = deserializeDashboardConfig(jsonString);
  }
  Future restoreFromSp() async {
    cachedConnectionString.value = await restoreKey("cachedConnectionString");
    if (sp.containsKey("dashboardConfiguration")) {
      dashboardConfigSerialized = await restoreKey("dashboardConfiguration"); // automatically deserialize config
    }else{
      dashboardConfigSerialized = kDashboardConfig; // default config
    }
    ready.value = true;
  }
  Future<String> restoreKey(String key) async {
    if(sp.containsKey(key)) return (await sp.getString(key)) ?? "";
    return "";
  }
  @override
  void onInit() {
    super.onInit();
    ever(cachedConnectionString, (_) => sp.setString("cachedConnectionString", cachedConnectionString.value));
    ever(dashboardConfiguration, (_) => sp.setString("dashboardConfiguration", dashboardConfigSerialized));
  }
}

String serializeDashboardConfig(List<dynamic> config) {
  List<dynamic> fig = List.filled(config.length, null);
  for (var x = 0; x < config.length; x++) {
    var item = config[x];
    if (item is IntegrationUiDefinition) {
      var uiDef = item.toJson();
      fig[x] = uiDef;
    }else if(item is List){
      fig[x] = jsonDecode(serializeDashboardConfig(item));
    }else{
      print("Unknown dashboard config item type: ${item.runtimeType}");
      fig[x] = item;
    }
  }
  return JsonEncoder.withIndent("  ").convert(fig);
}

List<dynamic> deserializeDashboardConfig(String jsonString) {
  List<dynamic> raw = jsonDecode(jsonString);
  List<dynamic> fig = List.filled(raw.length, null);
  for (var x = 0; x < raw.length; x++) {
    var item = raw[x];
    if (item is Map<String, dynamic> && item.containsKey("type") && item.containsKey("label") && item.containsKey("integrationId") && item.containsKey("evaluatorScript") && item.containsKey("outputTransformer")) {
      fig[x] = IntegrationUiDefinition.fromJson(item);
    }else if(item is List){
      fig[x] = deserializeDashboardConfig(jsonEncode(item));
    }else{
      print("Unknown dashboard config item type during deserialization: ${item.runtimeType}");
      fig[x] = item;
    }
  }
  return fig;
}