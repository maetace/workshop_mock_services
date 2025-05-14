import 'package:get/get.dart';
import 'package:workshop_0/pages/new_post/new_post_controller.dart';

class NewPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewPostController());
  }
}
