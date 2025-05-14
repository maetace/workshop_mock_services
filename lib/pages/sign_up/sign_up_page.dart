import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/sign_up/sign_up_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  static const title = 'Sign Up';
  static const route = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24.0,
            children: [
              Image.asset(
                'assets/images/twitter_logo.png',
                width: 48,
                height: 48,
                color: Colors.white,
              ),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                  keyboardType: TextInputType.name,
                  key: controller.fullNameKey,
                  controller: controller.fullNameEditingController,
                  validator: controller.fullNameValidator,
                  onChanged: controller.onFullNameChanged,
                  enabled: !controller.isLoading,
                ),
              ),
              Obx(
                () => DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Gender'),
                  key: controller.genderKey,
                  items:
                      controller.genders.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  validator: controller.genderValidator,
                  onChanged:
                      controller.isLoading ? null : controller.onGenderChanged,
                ),
              ),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  key: controller.emailKey,
                  controller: controller.emailEditingController,
                  validator: controller.emailValidator,
                  onChanged: controller.onEmailChanged,
                  enabled: !controller.isLoading,
                ),
              ),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  key: controller.usernameKey,
                  controller: controller.usernameEditingController,
                  validator: controller.usernameValidator,
                  onChanged: controller.onUsernameChanged,
                  enabled: !controller.isLoading,
                ),
              ),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  key: controller.passwordKey,
                  controller: controller.passwordEditingController,
                  validator: controller.passwordValidator,
                  onChanged: controller.onPasswordChanged,
                  enabled: !controller.isLoading,
                ),
              ),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading ? null : controller.onSignUpPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text('Sign Up'),
                      !controller.isLoading
                          ? SizedBox()
                          : SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: controller.onBackPressed,
        icon: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
