import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/submit_project_controller.dart';

class SubmitProjectView extends GetView<SubmitProjectController> {
  const SubmitProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubmitProjectView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubmitProjectView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
