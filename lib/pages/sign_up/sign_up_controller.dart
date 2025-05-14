import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/home/home_page.dart';
import 'package:workshop_0/services/account_service.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fullNameKey = GlobalKey<FormFieldState>();
  final fullNameEditingController = TextEditingController();

  final emailKey = GlobalKey<FormFieldState>();
  final emailEditingController = TextEditingController();

  final usernameKey = GlobalKey<FormFieldState>();
  final usernameEditingController = TextEditingController();

  final passwordKey = GlobalKey<FormFieldState>();
  final passwordEditingController = TextEditingController();

  final genders = <String>['Male', 'Female'];
  final genderKey = GlobalKey<FormFieldState>();
  String? _selectedGender;

  String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length > 250) {
      return 'Full name must be no longer than 250 character';
    }
    return null;
  }

  void onFullNameChanged(String value) {
    fullNameKey.currentState?.validate();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    RegExp regEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regEx.hasMatch(value)) {
      return 'Email is incorrect format';
    }
    return null;
  }

  void onEmailChanged(String value) {
    emailKey.currentState?.validate();
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length > 100) {
      return 'Username must be no longer than 100 characters';
    }
    RegExp regEx = RegExp(r'^[a-zA-Z0-9]+$');
    if (!regEx.hasMatch(value)) {
      return 'Username must be alphabet and digit only';
    }
    return null;
  }

  void onUsernameChanged(String value) {
    usernameKey.currentState?.validate();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    RegExp regEx = RegExp(r'^(?=.*[a-zA-Z]).+$');
    if (!regEx.hasMatch(value)) {
      return 'Password must be at least 1 alphabet';
    }
    regEx = RegExp(r'^(?=.*\d).+$');
    if (!regEx.hasMatch(value)) {
      return 'Password must be at least 1 digit';
    }
    regEx = RegExp(r'^(?=.*[\W_]).+$');
    if (!regEx.hasMatch(value)) {
      return 'Password must be at least 1 special character';
    }
    return null;
  }

  void onPasswordChanged(String value) {
    passwordKey.currentState?.validate();
  }

  String? genderValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }
    return null;
  }

  void onGenderChanged(String? value) {
    if (!genderKey.currentState!.validate()) {
      return;
    }
    _selectedGender = value;
  }

  void onBackPressed() {
    Get.back();
  }

  late AccountService _accountService;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _accountService = Get.find();
    super.onInit();
  }

  Future<void> onSignUpPressed() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      _isLoading.value = true;

      await _accountService.signUp(
        fullNameEditingController.text,
        _selectedGender!,
        emailEditingController.text,
        usernameEditingController.text,
        passwordEditingController.text,
      );

      Get.snackbar('Sign up successfully', 'Hello, Demo User!');
      Get.offAllNamed(HomePage.route);
    } catch (e) {
      Get.snackbar('Sign up failed', '$e');
    } finally {
      _isLoading.value = false;
    }
  }
}
