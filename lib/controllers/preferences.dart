import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

class PreferencesController extends GetxController {
  final sp = SharedPreferences.getInstance();
  @override
  void onInit() {
    super.onInit();
    Get.put(sp);
  }
}