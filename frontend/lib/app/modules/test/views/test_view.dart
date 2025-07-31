import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
