import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/app_list/widgets/post_item_controller.dart';
import 'package:workshop_0/services/models/post_item.dart';
import 'package:workshop_0/utils.dart';

class PostItemWidget extends GetView<PostItemController> {
  const PostItemWidget({super.key, required this.item});

  final PostItem item;

  @override
  String? get tag => item.id;

  @override
  PostItemController get controller => Get.put(PostItemController(), tag: tag);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onCardTap(item);
      },
      child: Card(
        margin: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ownerImage, ownerName, menu button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 4.0,
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 15,
                          foregroundImage: AssetImage(item.ownerImage),
                          child: Text(item.ownerName.substring(0, 2)),
                        ),
                      ),
                      Text(item.ownerName),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
                ],
              ),
            ),
            // photo slider
            CarouselSlider(
              carouselController: controller.carouselSliderController,
              items:
                  item.images.map((image) {
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
                height: 256,
                viewportFraction: 1,
                onPageChanged: controller.onPageChanged,
              ),
            ),
            // photo slider indicator
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    item.images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap:
                            () => controller.carouselSliderController
                                .animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
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
                            Text('${item.likes}'),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Row(
                          children: [
                            Icon(Icons.comment_outlined),
                            Text('${item.comments}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_outline),
                  ),
                ],
              ),
            ),
            // ownerName, description
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                spacing: 4.0,
                children: [
                  Text(
                    item.ownerName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // createdDate
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text('${item.createdDate}'),
            ),
            SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }
}
