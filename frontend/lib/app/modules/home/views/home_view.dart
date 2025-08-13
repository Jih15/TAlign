import 'package:flutter/material.dart';
import 'package:frontend/app/modules/home/widget/custom_appbar.dart';
import 'package:frontend/app/modules/home/widget/feature_card.dart';
import 'package:frontend/app/modules/home/widget/submission_history.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/widgets/background_wrapper.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
            child: CustomAppbar(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(kToolbarHeight * 2),
                Obx(() {
                  final username = controller.username ?? 'Guest';
                  return Text(
                    'Hello, $username!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: color.onSurface,
                    ),
                  );
                }),
                Text(
                  'Help your project ideas with us :)',
                  style: TextStyle(
                    fontSize: 16,
                    color: color.onSurface,
                  ),
                ),
                const Gap(28),
                const FeatureCard(),
                Gap(20),
                Text(
                  'Submission History',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(12),
                SubmissionHistory(),
                Gap(20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
                  onPressed: () => Get.toNamed(Routes.TEST),
                  child: Text('Go to test arena'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
