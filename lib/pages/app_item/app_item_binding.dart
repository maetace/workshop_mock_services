import 'package:get/get.dart';
import 'package:workshop_0/pages/app_item/app_item_controller.dart';

class AppItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppItemController());
  }
}
