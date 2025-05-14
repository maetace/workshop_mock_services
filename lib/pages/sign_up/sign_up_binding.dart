import 'package:get/get.dart';
import 'package:workshop_0/pages/sign_up/sign_up_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
