import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/app_list/app_list_controller.dart';
import 'package:workshop_0/pages/app_list/widgets/post_item_widget.dart';
import 'package:workshop_0/pages/app_list/widgets/post_item_placeholder_widget.dart';

class AppListPage extends GetView<AppListController> {
  const AppListPage({super.key});

  static const title = 'Apps';
  static const route = '/apps';

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
          if (controller.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.0,
                children: [
                  Text('No posts found'),
                  ElevatedButton(
                    onPressed: controller.onRefresh,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.onRefresh,
            child: ListView.separated(
              controller: controller.scrollController,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                var item = controller.items[index];

                if (item == null) {
                  return PostItemPlaceholderWidget();
                } else {
                  return PostItemWidget(item: item);
                }
              },
              itemCount: controller.items.length,
              physics:
                  controller.isLoading && controller.pageIndex == 1
                      ? NeverScrollableScrollPhysics()
                      : AlwaysScrollableScrollPhysics(),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.newPost,
        child: Icon(Icons.post_add),
      ),
    );
  }
}
