import 'package:flutter/material.dart';
import 'package:frontend/app/modules/login/controllers/login_controller.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:frontend/utils/widgets/custom_textfield.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignUpForm extends GetView<LoginController> {
  const SignUpForm ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(16),
        const Text('Username', style: TextStyle(color: Colors.black)),
        const Gap(4),
        CustomTextField(
          controller: controller.usernameController,
          hintText: 'Enter new username!',
          forceLightMode: true,
        ),
        const Gap(16),
        const Text('Email', style: TextStyle(color: Colors.black)),
        const Gap(4),
        CustomTextField(
          controller: controller.emailController,
          hintText: 'Enter your email!',
          forceLightMode: true,
        ),
        const Gap(16),
        const Text('Password', style: TextStyle(color: Colors.black)),
        const Gap(4),
        // TextFormField(
        //   style: const TextStyle(color: Colors.black),
        //   controller: controller.passwordController,
        //   obscureText: true,
        //   decoration: InputDecoration(
        //     filled: true,
        //     fillColor: ThemeApp.grayscaleAltLight,
        //     hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
        //     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(16),
        //       borderSide: BorderSide.none,
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: ThemeApp.grayscaleLight),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: const BorderSide(color: ThemeApp.grayscaleLight, width: 1.5),
        //     ),
        //   ),
        // ),
        CustomTextField(
          controller: controller.passwordController,
          hintText: 'Enter your password!',
          isPassword: true,
          isPasswordVisible: controller.isPasswordVisible,
          forceLightMode: true,
        ),
        const Gap(12),

        // Remember me + Forgot Password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Row(
              children: [
                Checkbox(
                  side: BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 1)
                  ),
                  value: controller.rememberMe.value,
                  onChanged: (val) => controller.rememberMe.value = val ?? false,
                ),
                const Text('Remember Me', style: TextStyle(color: Colors.grey)),
              ],
            )),
            Spacer(),
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

        Gap(24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF47846F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              controller.signUp();
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),


      ],
    );
  }
}