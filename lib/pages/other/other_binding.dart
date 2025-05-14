import 'package:get/get.dart';
import 'package:workshop_0/pages/other/other_controller.dart';

class OtherBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtherController());
  }
}
