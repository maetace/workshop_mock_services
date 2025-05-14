import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/welcome/welcome_controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  static const title = 'Welcome';
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/twitter_logo.png',
              width: 48,
              height: 48,
              color: Colors.white,
            ),
            SizedBox(height: 48),
            Text(
              'Welcome to Twitter',
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 24),
            Text(
              'See what\'s happening in the world right now',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.onSignUpPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      side: BorderSide(color: Colors.blue.shade200),
                    ),
                    child: Text('Sign Up'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.onLogInPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      side: BorderSide(color: Colors.blue.shade200),
                    ),
                    child: Text('Log In'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
