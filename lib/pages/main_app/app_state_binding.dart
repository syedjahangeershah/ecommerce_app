import 'package:assessment/pages/main_app/app_state_controller.dart';
import 'package:get/get.dart';

class AppStateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AppState());
  }
}