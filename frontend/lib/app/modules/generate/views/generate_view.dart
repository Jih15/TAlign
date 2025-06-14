import 'package:Cek_Tugas_Akhir/app/routes/app_pages.dart';
import 'package:Cek_Tugas_Akhir/utils/constant_assets.dart';
import 'package:Cek_Tugas_Akhir/utils/widgets/custom_dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/generate_controller.dart';

class GenerateView extends GetView<GenerateController> {
  const GenerateView({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fields = ['AI', 'Web', 'Mobile', 'IoT'];
    final difficulties = ['Easy', 'Medium', 'Hard'];

    final selectedField = RxnString();
    final selectedDifficulty = RxnString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setBgImg(isDarkMode);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Generate Ideas'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Get.offNamed(Routes.HOME);
          },
          icon: Image.asset(
            color: color.onSurface,
            ConstantAssets.icoBackDark,
            height: 32,
            width: 32,
            scale: 0.8,
          ),
        ),
      ),
      body: Obx(() => Stack(
        children: [
          SizedBox(
            child: Image.asset(
              controller.bgImagePath.value,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight *3,),
                Text(
                  'Generate Project\nIdeas',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(16),
                Text(
                  'Generate project ideas base on field and \ndifficulty level',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(36),
                CustomDropdownField(
                  hint: 'Field', 
                  items: fields, 
                  value: selectedField.value, 
                  onChanged: (val) => selectedField.value = val, 
                  itemBuilder: (item) => Text(item, style: const TextStyle(color: Colors.white)),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
