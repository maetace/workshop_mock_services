import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:workshop_0/pages/games_list/game_list_controller.dart';

class GameListPage extends GetView<GameListController> {
  const GameListPage({super.key});

  static const title = 'Games';
  static const route = '/games';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: controller.onMenuButtonPressed,
          icon: Icon(Icons.menu),
        ),
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: [
            Text(controller.content),
            ElevatedButton(
              onPressed: controller.openOtherPageFullScreen,
              child: Text('open Other Page full screen'),
            ),
            ElevatedButton(
              onPressed: controller.openOtherPageInsideTab,
              child: Text('open Other Page inside tab'),
            ),
          ],
        ),
      ),
    );
  }
}
