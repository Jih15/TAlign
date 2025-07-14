import 'package:flutter/material.dart';
import 'package:frontend/app/modules/home/widget/custom_appbar.dart';
import 'package:frontend/app/modules/home/widget/feature_card.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setBgImg(isDarkMode);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
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
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppbar(),
                  const Gap(52),
                  Text(
                    'Hello, Jih!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: color.onSurface,
                    ),
                  ),
                  Text(
                    'Help your project ideas with us :)',
                    style: TextStyle(
                      fontSize: 16,
                      color: color.onSurface,
                    ),
                  ),
                  const Gap(28),
                  const FeatureCard(),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
