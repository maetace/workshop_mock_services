import 'package:get/get.dart';
import 'package:workshop_0/pages/app_list/app_list_controller.dart';

class AppListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppListController());
  }
}
