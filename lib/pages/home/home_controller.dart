import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/app_item/app_item_binding.dart';
import 'package:workshop_0/pages/app_item/app_item_page.dart';
import 'package:workshop_0/pages/app_list/app_list_binding.dart';
import 'package:workshop_0/pages/app_list/app_list_page.dart';
import 'package:workshop_0/pages/games_list/game_list_binding.dart';
import 'package:workshop_0/pages/games_list/game_list_page.dart';
import 'package:workshop_0/pages/other/other_binding.dart';
import 'package:workshop_0/pages/other/other_page.dart';
import 'package:workshop_0/pages/welcome/welcome_page.dart';
import 'package:workshop_0/services/account_service.dart';
import 'package:workshop_0/widgets/loading_overlay/loading_overlay_controller.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _currentTabIndex = 0.obs;
  int get currentTabIndex => _currentTabIndex.value;

  // list of get page routes that we can nav inside tab
  // the order must be same as bottom nav bar
  final _routes = <GetPageRoute>[
    GetPageRoute(
      routeName: AppListPage.route,
      page: () => AppListPage(),
      binding: AppListBinding(),
    ),
    GetPageRoute(
      routeName: GameListPage.route,
      page: () => GameListPage(),
      binding: GameListBinding(),
    ),
    GetPageRoute(
      routeName: OtherPage.route,
      page: () => OtherPage(),
      binding: OtherBinding(),
    ),
    GetPageRoute(
      routeName: AppItemPage.route,
      page: () => AppItemPage(),
      binding: AppItemBinding(),
    ),
  ];

  late LoadingOverlayController _loadingOverlayController;
  late AccountService _accountService;

  void onBottomNavigationBarItemTap(int targetTabIndex) {
    if (_currentTabIndex.value == targetTabIndex) {
      // when user tap current tab again
      // get nav key for current tab
      final navKey = Get.keys[_currentTabIndex.value];
      // find current route
      String? currentRoute;
      navKey?.currentState?.popUntil((route) {
        currentRoute = route.settings.name;
        return true;
      });
      // find target route
      final targetRoute = _routes[targetTabIndex].routeName;

      if (currentRoute != targetRoute) {
        // when current route != target route
        // then pop until found target route
        navKey?.currentState?.popUntil((route) {
          return targetRoute == route.settings.name;
        });
      } else {
        // when current route == target route
      }
    }

    // update _selectedTabIndex
    _currentTabIndex.value = targetTabIndex;
  }

  Route? onGenerateRoute(RouteSettings settings) {
    var route = _routes.firstWhereOrNull(
      (route) => route.routeName == settings.name,
    );

    if (route != null) {
      // fix GetX can't pass arguments for nested nav
      Get.routing.args = settings.arguments;
      // create get page route
      route = GetPageRoute(
        settings: settings,
        page: route.page,
        binding: route.binding,
      );
    }

    return route;
  }

  void onOpenOtherPageFullScreenItemTap() {
    scaffoldKey.currentState?.closeDrawer();
    Get.toNamed(OtherPage.route);
  }

  void onOpenOtherPageInsideTabItemTap() {
    scaffoldKey.currentState?.closeDrawer();
    Get.toNamed(OtherPage.route, id: _currentTabIndex.value);
  }

  @override
  void onInit() {
    _loadingOverlayController = Get.find();
    _accountService = Get.find();
    super.onInit();
  }

  void onLogOutItemTap() {
    scaffoldKey.currentState?.closeDrawer();
    Get.defaultDialog(
      title: 'Log Out?',
      content: Text('Are you sure you want to log out?'),
      textCancel: 'No',
      textConfirm: 'Yes',
      onCancel: () {
        Get.back();
      },
      onConfirm: () async {
        Get.back();

        try {
          _loadingOverlayController.show();

          await _accountService.logOut();

          Get.snackbar('Log out successfully', 'See you again');
          Get.offAllNamed(WelcomePage.route);
        } finally {
          _loadingOverlayController.hide();
        }
      },
    );
  }
}
