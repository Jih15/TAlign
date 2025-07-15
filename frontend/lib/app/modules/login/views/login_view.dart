import 'package:flutter/material.dart';
import 'package:frontend/app/modules/login/widget/LoginSignUpSwitcher.dart';
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

    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          final imagePath = controller.bgImagePath.value;
          return Stack(
            children: [
              if (imagePath.isNotEmpty)
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx((){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.isLogin.value
                                ? 'Welcome!\nLogin To Your \nAccount!' : 'Welcome!\nLet\'s Setup Your \nAccount!',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          Gap(16),
                          Text(
                            controller.isLogin.value
                                ? 'Login to continue!' : 'Set up your account to continue!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      );
                    }),
                    Gap(20),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: screenWidth,
                          height: screenHeight,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LoginSignUpSwitcher(
                                isLogin: controller.isLogin,
                                onToggle: controller.toggleTab,
                                width: screenWidth - 32, // sesuaikan dengan padding horizontal
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: Center(
                                  child: Obx(() {
                                    return Text(
                                      controller.isLogin.value ? 'Ini view Login' : 'Ini view Sign Up',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
          );
        })
      ),
    );
  }
}
