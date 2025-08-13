import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestController extends GetxController {

  final testTEController = TextEditingController();

  void testSnackbar(){
    Get.snackbar('Test', 'Test Snackbar');
  }
}
