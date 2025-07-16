import 'package:frontend/app/modules/login/controllers/login_controller.dart';
import 'package:frontend/app/modules/login/widget/form/login_form.dart';
import 'package:frontend/app/modules/login/widget/form/signup_form.dart';
import 'package:frontend/app/modules/login/widget/login_signup_switcher.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginContainer extends GetView<LoginController>{
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: isDarkMode
              ? Border.all(
                  color: Colors.transparent,
                )
              : Border.all(
                  color: Color(0xFFEBEBEB)
                ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(44),
            topRight: Radius.circular(44),
          ),
          boxShadow: isDarkMode
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.transparent,
                  )
                ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginSignUpSwitcher(
              isLogin: controller.isLogin,
              onToggle: controller.toggleTab,
              width: screenWidth - 16,
            ),
            Gap(20),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  return controller.isLogin.value
                      ? LoginForm()
                      : SignUpForm();
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}