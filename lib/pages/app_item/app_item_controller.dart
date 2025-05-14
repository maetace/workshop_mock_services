import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/services/comment_service.dart';
import 'package:workshop_0/services/models/comment_item.dart';
import 'package:workshop_0/services/models/post_item.dart';

class AppItemController extends GetxController {
  late PostItem _postItem;
  PostItem get postItem => _postItem;

  final _currentPage = 0.obs;
  int get currentPage => _currentPage.value;
  final carouselSliderController = CarouselSliderController();

  late CommentService _commentService;
  final _commentItems = <CommentItem?>[].obs;
  List<CommentItem?> get commentItems => _commentItems;
  final _pageIndex = 1.obs;
  int get pageIndex => _pageIndex.value;
  final _pageSize = 3;
  var _hasMoreItems = false;
  final _loading = false.obs;
  bool get loading => _loading.value;

  final scrollController = ScrollController();

  final _canComment = false.obs;
  bool get canComment => _canComment.value;
  final commentTextEditingController = TextEditingController();
  var _isCommentCreating = false;

  @override
  void onInit() {
    // item from previous page
    _postItem = Get.arguments as PostItem;

    _commentService = Get.find();

    scrollController.addListener(_onScrolling);
    super.onInit();
  }

  @override
  void onReady() {
    _loadCommentItems();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScrolling);
    scrollController.dispose();
    super.onClose();
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    _currentPage.value = index;
  }

  Future<void> _loadCommentItems() async {
    if (_loading.value) {
      return;
    }

    try {
      _loading.value = true;

      if (_pageIndex.value == 1) {
        _commentItems.clear();
      }

      _commentItems.addAll(
        List.generate(_pageIndex.value == 1 ? _pageSize : 1, (index) => null),
      );

      var newItems = await _commentService.getComments(
        _postItem.id,
        pageIndex: _pageIndex.value,
        pageSize: _pageSize,
      );

      _commentItems.removeWhere((item) => item == null);

      _commentItems.addAll(newItems);

      _hasMoreItems = newItems.length >= _pageSize;
    } finally {
      _loading.value = false;
    }
  }

  void _onScrolling() {
    var isLastItem =
        scrollController.position.pixels >=
        scrollController.position.maxScrollExtent;
    if (isLastItem && _hasMoreItems && !_loading.value) {
      _pageIndex.value++;
      _loadCommentItems();
    }
  }

  void _validate() {
    _canComment.value =
        commentTextEditingController.text.isNotEmpty && !_isCommentCreating;
  }

  void onCommentTextChanged(String comment) {
    _validate();
  }

  Future<void> createComment() async {
    // scroll to top
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Durations.medium1,
      curve: Curves.linear,
    );
    // insert empty comment at top to show placeholder item
    _commentItems.insert(0, null);
    // trim comment text
    var comment = commentTextEditingController.text.trim();
    // clear comment text field
    commentTextEditingController.clear();
    // begin comment
    _isCommentCreating = true;
    // update can comment
    _validate();
    // call api to create comment
    var newComment = await _commentService.createCommentItem(comment);
    // remove placeholder item
    _commentItems.removeAt(0);
    // insert new comment into top
    _commentItems.insert(0, newComment);
    // finish comment
    _isCommentCreating = false;
    // update can comment
    _validate();
  }
}
