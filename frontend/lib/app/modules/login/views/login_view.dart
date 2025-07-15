import 'package:flutter/material.dart';
import 'package:frontend/app/modules/login/widget/login_container.dart';
import 'package:frontend/app/modules/login/widget/login_greeting.dart';
import 'package:frontend/app/modules/login/widget/login_signup_switcher.dart';
import 'package:frontend/utils/widgets/background_wrapper.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // final containerWidth = screenWidth * 0.85;
    // final switcherWidth = screenWidth * 0.75;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setBgImg(isDarkMode);
    });

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Obx(() => LoginGreeting(isLogin: controller.isLogin.value)),
                const SizedBox(height: 20),
                const Expanded(child: LoginContainer()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
