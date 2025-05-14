import 'package:get/get.dart';
import 'package:workshop_0/pages/home/home_controller.dart';
import 'package:workshop_0/pages/other/other_page.dart';

class GameListController extends GetxController {
  final content = 'Game list page';

  late HomeController _homeController;

  @override
  void onInit() {
    _homeController = Get.find();
    super.onInit();
  }

  void openOtherPageFullScreen() {
    Get.toNamed(OtherPage.route);
  }

  void openOtherPageInsideTab() {
    Get.toNamed(OtherPage.route, id: _homeController.currentTabIndex);
  }

  void onMenuButtonPressed() {
    _homeController.scaffoldKey.currentState?.openDrawer();
  }
}
