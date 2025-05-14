import 'package:get/get.dart';

class LoadingOverlayController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void show() {
    _isLoading.value = true;
  }

  void hide() {
    _isLoading.value = false;
  }
}
