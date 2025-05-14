import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  final _canPost = false.obs;
  bool get canPost => _canPost.value;

  final descTextEditingController = TextEditingController();

  final _picker = ImagePicker();
  final _images = <XFile>[].obs;
  List<XFile> get images => _images;

  void _validate() {
    _canPost.value =
        descTextEditingController.text.isNotEmpty && _images.isNotEmpty;
  }

  void onDescTextChanged(String value) {
    _validate();
  }

  Future<void> onSelectPhotoButtonPressed() async {
    final result = await _picker.pickImage(source: ImageSource.gallery);
    if (result == null) {
      return;
    }
    if (_images.length == 4) {
      return;
    }
    _images.add(result);
    _validate();
  }

  void onRemovePhotoButtonPressed(int index) {
    _images.removeAt(index);
    _validate();
  }

  void onPostButtonPressed() {
    Get.back(
      result: {
        'description': descTextEditingController.text.trim(),
        'images': _images.map((f) => f.path).toList(),
      },
    );
  }
}
