import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workshop_0/pages/app_item/app_item_controller.dart';
import 'package:workshop_0/services/models/comment_item.dart';
import 'package:workshop_0/utils.dart';

class AppItemPage extends GetView<AppItemController> {
  static const title = 'App Item';
  static const route = '/appitem';

  const AppItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 4.0,
          children: [
            Container(
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 15.0,
                foregroundImage: AssetImage(controller.postItem.ownerImage),
              ),
            ),
            Text('${controller.postItem.ownerName}\'s post'),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          physics: BouncingScrollPhysics(),
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.stylus,
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
          },
        ),
        child: Obx(() {
          if (controller.commentItems.isEmpty) {
            // post item detail and no comments
            return _createPostItemWithCommentItem(
              context,
              ListTile(subtitle: Text('No comments')),
            );
          } else {
            // post item detail and comment list
            return ListView.separated(
              controller: controller.scrollController,
              itemCount: controller.commentItems.length,
              itemBuilder: (context, index) {
                final item = controller.commentItems[index];
                // create comment item placeholder
                var commentWidget = _createCommentItemPlaceholder(context);
                // create comment item when item is not null
                if (item != null) {
                  commentWidget = _createCommentItem(item);
                }
                if (index == 0) {
                  // for first item -> create item detail with first comment
                  return _createPostItemWithCommentItem(context, commentWidget);
                }
                if (index + 1 == controller.commentItems.length) {
                  // for last item -> put comment with sized box
                  return Column(
                    children: [commentWidget, SizedBox(height: 80.0)],
                  );
                }
                // put comment
                return commentWidget;
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          }
        }),
      ),
      // comment box
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 8.0,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.commentTextEditingController,
                  decoration: InputDecoration(hintText: 'Write a comment'),
                  onChanged: controller.onCommentTextChanged,
                ),
              ),
              Obx(
                () => IconButton(
                  onPressed:
                      controller.canComment ? controller.createComment : null,
                  icon: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _createCommentItem(CommentItem item) {
    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        foregroundImage: AssetImage(item.ownerImage),
      ),
      title: Text(item.ownerName),
      subtitle: Text(item.message),
    );
  }

  ListTile _createCommentItemPlaceholder(BuildContext context) {
    return ListTile(
      leading: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        highlightColor: Theme.of(context).colorScheme.surfaceContainerLow,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        highlightColor: Theme.of(context).colorScheme.surfaceContainerLow,
        child: Column(
          spacing: 8.0,
          children: [
            Container(
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
            ),
            Container(
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _createPostItemWithCommentItem(
    BuildContext context,
    ListTile commentWidget,
  ) {
    return Column(
      children: [
        // photo slider
        CarouselSlider(
          carouselController: controller.carouselSliderController,
          items:
              controller.postItem.images.map((image) {
                return isWebPath(image)
                    ? Image.network(
                      image,
                      width: Get.width,
                      fit: BoxFit.fitWidth,
                    )
                    : Image.asset(
                      image,
                      width: Get.width,
                      fit: BoxFit.fitWidth,
                    );
              }).toList(),
          options: CarouselOptions(
            height: 320,
            viewportFraction: 1,
            onPageChanged: controller.onPageChanged,
          ),
        ),
        // photo slider indicator
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                controller.postItem.images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap:
                        () => controller.carouselSliderController.animateToPage(
                          entry.key,
                        ),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withValues(
                              alpha:
                                  controller.currentPage == entry.key
                                      ? 0.9
                                      : 0.4,
                            ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
        // likes, comments, bookmark buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4.0,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Row(
                    children: [
                      Icon(Icons.favorite_outline),
                      Text('${controller.postItem.likes}'),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Row(
                    children: [
                      Icon(Icons.comment_outlined),
                      Text('${controller.postItem.comments}'),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
          ],
        ),
        // ownerName, createdDate
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(children: [Text(controller.postItem.description)]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(children: [Text('${controller.postItem.createdDate}')]),
        ),
        Divider(),
        commentWidget,
      ],
    );
  }
}
