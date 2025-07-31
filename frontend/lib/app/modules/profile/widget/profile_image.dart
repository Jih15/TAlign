import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';

class ProfileAvatarWithEditButton extends StatelessWidget {
  final String imageUrl;

  const ProfileAvatarWithEditButton({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ThemeApp.greenSoft,
              width: 4,
            ),
          ),
          child: CircleAvatar(
            radius: 80, // Adjust radius as needed
            backgroundImage: AssetImage(imageUrl),
            backgroundColor: Colors.grey[200], // Placeholder color
          ),
        ),
        // Positioned(
        //   bottom: 4,
        //   right: 20,
        //   child: GestureDetector(
        //     onTap: onEditPressed,
        //     child: CircleAvatar(
        //       radius: 12,
        //       backgroundColor: ThemeApp.greenSoft,
        //       child: Icon(
        //         Icons.edit,
        //         color: Colors.white,
        //         size: 16,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}