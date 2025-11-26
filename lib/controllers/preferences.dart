import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

class PreferencesController extends GetxController {
  final SharedPreferences sp = Get.find<SharedPreferences>();
  var ready = false.obs;

  String cachedConnectionString = "";
  Future restoreFromSp() async {
    if(sp.containsKey("cachedConnectionString")) cachedConnectionString = (await sp.getString("")) ?? "";
    
    ready.value = true;
  }
  @override
  void onInit() {
    super.onInit();
  }
}
