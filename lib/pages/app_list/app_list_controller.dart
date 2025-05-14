import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/home/home_controller.dart';
import 'package:workshop_0/pages/new_post/new_post_page.dart';
import 'package:workshop_0/pages/other/other_page.dart';
import 'package:workshop_0/services/models/post_item.dart';
import 'package:workshop_0/services/post_service.dart';

class AppListController extends GetxController {
  final content = 'App list page';

  late HomeController _homeController;
  late PostService _postService;

  final scrollController = ScrollController();
  final _items = <PostItem?>[].obs;
  List<PostItem?> get items => _items;
  final _pageIndex = 1.obs;
  int get pageIndex => _pageIndex.value;
  final int _pageSize = 3;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  bool _hasMoreItems = false;

  @override
  void onInit() {
    _homeController = Get.find();
    _postService = Get.find();
    scrollController.addListener(_onScrolling);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  Future<void> onReady() async {
    await _loadItems();
    super.onReady();
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

  Future<void> onRefresh() async {
    _pageIndex.value = 1;
    await _loadItems();
  }

  void _onScrolling() {
    var isLastItem =
        scrollController.position.pixels >=
        scrollController.position.maxScrollExtent;
    if (isLastItem && _hasMoreItems && !_isLoading.value) {
      _pageIndex.value++;
      _loadItems();
    }
  }

  Future<void> _loadItems() async {
    if (_isLoading.value) {
      return;
    }

    try {
      _isLoading.value = true;
      // clear old items when _pageIndex == 1
      if (_pageIndex.value == 1) {
        _items.clear();
      }
      // generate null item for showing item place holder
      _items.addAll(
        List.generate(_pageIndex.value == 1 ? _pageSize : 1, (index) => null),
      );
      // get new items from api
      var newItems = await _postService.getPostItems(
        pageIndex: _pageIndex.value,
        pageSize: _pageSize,
      );
      // remove all null items
      _items.removeWhere((item) => item == null);
      // add item from api
      _items.addAll(newItems);

      _hasMoreItems = newItems.length >= _pageSize;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> newPost() async {
    // open new post page
    var result = await Get.toNamed(NewPostPage.route);
    // check result from new post page
    if (result == null) {
      return;
    }
    // scroll to top
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Durations.medium1,
      curve: Curves.linear,
    );
    // insert empty item at top to show placeholder item
    _items.insert(0, null);
    // call api to create new post
    var newItem = await _postService.createPostItem(
      description: result['description'],
      images: result['images'],
    );
    // remove placeholder item
    _items.removeAt(0);
    // insert new item at top
    _items.insert(0, newItem);
  }
}
