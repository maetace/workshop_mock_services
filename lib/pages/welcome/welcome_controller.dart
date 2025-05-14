import 'package:get/get.dart';
import 'package:workshop_0/pages/home/home_page.dart';
import 'package:workshop_0/pages/log_in/log_in_page.dart';
import 'package:workshop_0/pages/sign_up/sign_up_page.dart';
import 'package:workshop_0/services/account_service.dart';
import 'package:workshop_0/widgets/loading_overlay/loading_overlay_controller.dart';

class WelcomeController extends GetxController {
  late LoadingOverlayController _loadingOverlayController;
  late AccountService _accountService;

  @override
  void onInit() {
    _loadingOverlayController = Get.find();
    _accountService = Get.find();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      _loadingOverlayController.show();

      if (await _accountService.isLoggedIn()) {
        Get.offAllNamed(HomePage.route);
      }
    } finally {
      _loadingOverlayController.hide();
    }

    super.onReady();
  }

  void onSignUpPressed() {
    Get.toNamed(SignUpPage.route);
  }

  void onLogInPressed() {
    Get.toNamed(LogInPage.route);
  }
}
