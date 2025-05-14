import 'package:get/get.dart';
import 'package:workshop_0/pages/log_in/log_in_controller.dart';

class LogInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogInController());
  }
}
