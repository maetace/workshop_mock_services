import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/app_list/app_list_page.dart';
import 'package:workshop_0/pages/games_list/game_list_page.dart';
import 'package:workshop_0/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static const title = 'Home';
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Mock Services')),
            ListTile(
              leading: Icon(Icons.fullscreen),
              title: Text('open Other Page full screen'),
              onTap: controller.onOpenOtherPageFullScreenItemTap,
            ),
            ListTile(
              leading: Icon(Icons.tab),
              title: Text('open Other Page inside tab'),
              onTap: controller.onOpenOtherPageInsideTabItemTap,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: controller.onLogOutItemTap,
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentTabIndex,
          children: [
            Navigator(
              key: Get.nestedKey(0),
              initialRoute: AppListPage.route,
              onGenerateRoute: controller.onGenerateRoute,
            ),
            Navigator(
              key: Get.nestedKey(1),
              initialRoute: GameListPage.route,
              onGenerateRoute: controller.onGenerateRoute,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 0,
          items: [
            _createBottomNavigationBarItem(
              0,
              AppListPage.title,
              Icons.app_shortcut_outlined,
              Icons.app_shortcut,
            ),
            _createBottomNavigationBarItem(
              1,
              GameListPage.title,
              Icons.gamepad_outlined,
              Icons.gamepad,
            ),
          ],
          currentIndex: controller.currentTabIndex,
          onTap: controller.onBottomNavigationBarItemTap,
        ),
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(
    int index,
    String label,
    IconData normalIcon,
    IconData selectedIcon,
  ) {
    return BottomNavigationBarItem(
      icon:
          controller.currentTabIndex == index
              ? Icon(selectedIcon)
              : Icon(normalIcon),
      label: label,
    );
  }
}
