import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TestView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                CherryToast.warning(
                  animationDuration: Duration(milliseconds: 300),
                  title: const Text("User added", style: TextStyle(color: Colors.black)),
                  action: const Text("Display information", style: TextStyle(color: Colors.black)),
                  actionHandler: () {
                    debugPrint("Action button pressed");
                  },
                ).show(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text('Show CherryToast'),
            ),
            ElevatedButton(
              onPressed: controller.testSnackbar,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text('Test Controller Snackbar'),
            ),
            Gap(30),
            Center(
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF111617) : Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Student Data?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Gap(12),
                    Text(
                      'Are you sure to update your student data?',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    Gap(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Get.back(result: false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4B8673),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 64, vertical: 16,
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                            ),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),

                      ],
                    )
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
