import 'package:get/get.dart';
import 'package:workshop_0/pages/games_list/game_list_controller.dart';

class GameListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameListController());
  }
}
