import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/log_in/log_in_controller.dart';

class LogInPage extends GetView<LogInController> {
  const LogInPage({super.key});

  static const title = 'Log In';
  static const route = '/login';

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
                  key: controller.passwordKey,
                  obscureText: true,
                  controller: controller.passwordEditingController,
                  validator: controller.passwordValidator,
                  onChanged: controller.onPasswordChanged,
                  enabled: !controller.isLoading,
                ),
              ),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading ? null : controller.onLogInPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text('Log In'),
                      controller.isLoading
                          ? SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(),
                          )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => IconButton(
          onPressed: controller.isLoading ? null : controller.onBackPressed,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
