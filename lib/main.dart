import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:workshop_0/pages/home/home_binding.dart';
import 'package:workshop_0/pages/home/home_page.dart';
import 'package:workshop_0/pages/log_in/log_in_binding.dart';
import 'package:workshop_0/pages/log_in/log_in_page.dart';
import 'package:workshop_0/pages/new_post/new_post_binding.dart';
import 'package:workshop_0/pages/new_post/new_post_page.dart';
import 'package:workshop_0/pages/other/other_binding.dart';
import 'package:workshop_0/pages/other/other_page.dart';
import 'package:workshop_0/pages/sign_up/sign_up_binding.dart';
import 'package:workshop_0/pages/sign_up/sign_up_page.dart';
import 'package:workshop_0/pages/welcome/welcome_binding.dart';
import 'package:workshop_0/pages/welcome/welcome_page.dart';
import 'package:workshop_0/services/account_service.dart';
import 'package:workshop_0/services/account_service_mock.dart';
import 'package:workshop_0/services/comment_service.dart';
import 'package:workshop_0/services/comment_service_mock.dart';
import 'package:workshop_0/services/post_service.dart';
import 'package:workshop_0/services/post_service_mock.dart';
import 'package:workshop_0/widgets/loading_overlay/loading_overlay_controller.dart';
import 'package:workshop_0/widgets/loading_overlay/loading_overlay_widget.dart';

void main() {
  _init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) => GetMaterialApp(
            title: 'Workshop App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            initialRoute: WelcomePage.route,
            getPages: [
              GetPage(
                name: WelcomePage.route,
                page: () => LoadingOverlayWidget(child: WelcomePage()),
                binding: WelcomeBinding(),
              ),
              GetPage(
                name: LogInPage.route,
                page: () => LogInPage(),
                binding: LogInBinding(),
              ),
              GetPage(
                name: SignUpPage.route,
                page: () => SignUpPage(),
                binding: SignUpBinding(),
              ),
              GetPage(
                name: HomePage.route,
                page: () => LoadingOverlayWidget(child: HomePage()),
                binding: HomeBinding(),
              ),
              GetPage(
                name: OtherPage.route,
                page: () => OtherPage(),
                binding: OtherBinding(),
                fullscreenDialog: true,
              ),
              GetPage(
                name: NewPostPage.route,
                page: () => NewPostPage(),
                binding: NewPostBinding(),
                fullscreenDialog: true,
              ),
            ],
          ),
    ),
  );
}

void _init() {
  // create LoadingOverlayController and permanent put in memory
  Get.put(LoadingOverlayController(), permanent: true);
  // create FlutterSecureStorage and permanent put in memory
  Get.put(FlutterSecureStorage(), permanent: true);
  // register service and create it when need
  Get.lazyPut<AccountService>(() => AccountServiceMock());
  Get.lazyPut<PostService>(() => PostServiceMock());
  Get.lazyPut<CommentService>(() => CommentServiceMock());
}
