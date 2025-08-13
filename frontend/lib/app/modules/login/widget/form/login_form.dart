import 'package:flutter/material.dart';
import 'package:frontend/app/modules/login/controllers/login_controller.dart';
import 'package:frontend/utils/widgets/custom_textfield.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),

        const Text('Username', style: TextStyle(color: Colors.black)),
        const Gap(4),
        CustomTextField(
          controller: controller.usernameController,
          hintText: 'Enter your username!',
          forceLightMode: true,
          errorText: controller.usernameError,
        ),
        const Gap(16),

        const Text('Password', style: TextStyle(color: Colors.black)),
        const Gap(4),
        CustomTextField(
          controller: controller.passwordController,
          hintText: 'Enter your password!',
          isPassword: true,
          isPasswordVisible: controller.isPasswordVisible,
          forceLightMode: true,
          errorText: controller.passwordError, // Tambahan untuk error
        ),
        const Gap(12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Row(
              children: [
                Checkbox(
                  side: const BorderSide(color: Color.fromRGBO(217, 217, 217, 1)),
                  value: controller.rememberMe.value,
                  onChanged: (val) => controller.rememberMe.value = val ?? false,
                ),
                const Text('Remember Me', style: TextStyle(color: Colors.grey)),
              ],
            )),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Forgot password logic
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Color(0xFF2F6C5D),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        const Gap(24),

        Obx(() => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFFD7680D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              controller.login();
            },
            child: controller.isLoading.value
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : const Text(
              'Login',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        )),
      ],
    );
  }
}
