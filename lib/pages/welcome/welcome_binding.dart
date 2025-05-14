import 'package:get/get.dart';
import 'package:workshop_0/pages/welcome/welcome_controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
