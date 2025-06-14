import 'package:Cek_Tugas_Akhir/utils/constant_assets.dart';
import 'package:Cek_Tugas_Akhir/utils/theme_app.dart';
import 'package:Cek_Tugas_Akhir/utils/widgets/custom_dropdownfield.dart';
import 'package:Cek_Tugas_Akhir/utils/widgets/custom_textfieldtest.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({super.key});
  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fields = ['AI', 'Web', 'Mobile', 'IoT'];
    final difficulties = ['Easy', 'Medium', 'Hard'];

    final selectedField = RxnString();
    final selectedDifficulty = RxnString();

    return Scaffold(
      backgroundColor: isDarkMode
        ? ThemeApp.grayscaleDark
        : ThemeApp.grayscaleFullLight,
      appBar: AppBar(
        title: const Text('TestView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'TestView is working',
                style: TextStyle(fontSize: 20),
              ),

              Obx(() => CustomDropdownField<String>(
                hint: 'Field',
                items: fields,
                value: selectedField.value,
                onChanged: (val) => selectedField.value = val,
                itemBuilder: (item) => Text(item, style: const TextStyle(color: Colors.white)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
