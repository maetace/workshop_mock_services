import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/new_post/new_post_controller.dart';
import 'package:workshop_0/utils.dart';

class NewPostPage extends GetView<NewPostController> {
  static const title = 'New Post';
  static const route = '/newpost';

  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New post'),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 8.0),
        actions: [
          Obx(
            () => ElevatedButton(
              onPressed:
                  controller.canPost ? controller.onPostButtonPressed : null,
              child: Text('Post'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        physics: BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            // text box
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  foregroundImage: AssetImage('assets/images/avatar.webp'),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    controller: controller.descTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'What\'s happening?',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    onChanged: controller.onDescTextChanged,
                  ),
                ),
              ],
            ),
            // image list
            Row(
              children: [
                SizedBox(width: 32),
                Obx(
                  () => Row(
                    children:
                        controller.images.asMap().entries.map((entry) {
                          final size = 64.0;
                          final index = entry.key;
                          final path = entry.value.path;
                          return Row(
                            children: [
                              SizedBox(width: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        isWebPath(path)
                                            ? Image.network(
                                              path,
                                              height: size,
                                              width: size,
                                              fit: BoxFit.cover,
                                            )
                                            : Image.file(
                                              File(path),
                                              height: size,
                                              width: size,
                                              fit: BoxFit.cover,
                                            ),
                                        Positioned(
                                          top: -10,
                                          right: -10,
                                          child: IconButton(
                                            onPressed: () {
                                              controller
                                                  .onRemovePhotoButtonPressed(
                                                    index,
                                                  );
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Row(
          children: [
            Obx(
              () => IconButton(
                onPressed:
                    controller.images.length < 4
                        ? controller.onSelectPhotoButtonPressed
                        : null,
                icon: Icon(Icons.photo_library),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
