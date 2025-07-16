import 'package:flutter/material.dart';
import 'package:frontend/utils/constant_assets.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  const BackgroundWrapper({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imagePath = isDark ? ConstantAssets.imgBgDark : ConstantAssets.imgBgLight;

    return Stack(
      children: [
        Container(
          color: isDark ? Colors.black : Colors.white,
        ),
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
