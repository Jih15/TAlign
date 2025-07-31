import 'package:flutter/material.dart';
import 'package:frontend/app/modules/login/widget/login_container.dart';
import 'package:frontend/app/modules/login/widget/login_greeting.dart';
import 'package:frontend/utils/widgets/background_wrapper.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                Obx(() => LoginGreeting(isLogin: controller.isLogin.value)),
                const Gap(20),
                const Expanded(child: LoginContainer()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
