import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/home/home_controller.dart';
import 'package:workshop_0/services/models/post_item.dart';

class PostItemController extends GetxController {
  final _currentPage = 0.obs;
  int get currentPage => _currentPage.value;
  final carouselSliderController = CarouselSliderController();

  late HomeController _homeController;

  @override
  void onInit() {
    _homeController = Get.find();
    super.onInit();
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    _currentPage.value = index;
  }

  void onCardTap(PostItem item) {
    // pass item to next page
    Get.toNamed(
      '/appitem',
      arguments: item,
      id: _homeController.currentTabIndex,
    );
  }
}
