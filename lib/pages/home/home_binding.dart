import 'package:get/get.dart';
import 'package:workshop_0/pages/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
