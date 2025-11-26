import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

class PreferencesController extends GetxController {
  final SharedPreferences sp = Get.find<SharedPreferences>();
  var ready = false.obs;

  RxString cachedConnectionString = "".obs;
  Future restoreFromSp() async {
    cachedConnectionString.value = await restoreKey("cachedConnectionString");
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
  }
}
