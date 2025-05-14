import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/home/home_page.dart';
import 'package:workshop_0/services/account_service.dart';

class LogInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameKey = GlobalKey<FormFieldState>();
  final usernameEditingController = TextEditingController();

  final passwordKey = GlobalKey<FormFieldState>();
  final passwordEditingController = TextEditingController();

  late AccountService _accountService;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  void onUsernameChanged(String value) {
    usernameKey.currentState!.validate();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void onPasswordChanged(String value) {
    passwordKey.currentState!.validate();
  }

  void onBackPressed() {
    Get.back();
  }

  @override
  void onInit() {
    _accountService = Get.find();
    super.onInit();
  }

  Future<void> onLogInPressed() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      _isLoading.value = true;

      await _accountService.logIn(
        usernameEditingController.text,
        passwordEditingController.text,
      );

      Get.snackbar('Log in successfully', 'Welcome back!');
      Get.offAllNamed(HomePage.route);
    } catch (e) {
      passwordEditingController.clear();

      Get.snackbar('Log in failed', '$e');
    } finally {
      _isLoading.value = false;
    }
  }
}
