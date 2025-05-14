import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PostItemPlaceholderWidget extends GetView {
  const PostItemPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(4.0),
    );

    final circleDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      shape: BoxShape.circle,
    );

    return Card(
      margin: EdgeInsets.all(0.0),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        highlightColor: Theme.of(context).colorScheme.surfaceContainerLow,
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
                    children: [
                      Container(
                        decoration: circleDecoration,
                        height: 32,
                        width: 32,
                      ),
                      SizedBox(width: 4.0),
                      Container(
                        decoration: boxDecoration,
                        height: 16,
                        width: 64,
                      ),
                    ],
                  ),
                  Container(decoration: boxDecoration, height: 32, width: 32),
                ],
              ),
            ),
            // photo slider
            Container(height: 256, decoration: boxDecoration),
            // photo slider indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.all(4.0),
                  decoration: circleDecoration,
                );
              }),
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
                    spacing: 4,
                    children: [
                      Container(
                        decoration: boxDecoration,
                        height: 32,
                        width: 64,
                      ),
                      Container(
                        decoration: boxDecoration,
                        height: 32,
                        width: 64,
                      ),
                    ],
                  ),
                  Container(decoration: boxDecoration, height: 32, width: 32),
                ],
              ),
            ),
            // ownerName, description
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Container(decoration: boxDecoration, height: 16),
            ),
            // createdDate
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Container(decoration: boxDecoration, height: 16),
            ),
            SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }
}
