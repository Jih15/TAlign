import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/similarity_controller.dart';

class SimilarityView extends GetView<SimilarityController> {
  const SimilarityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimilarityView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SimilarityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
