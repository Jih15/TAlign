import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';

class ProfileAvatarWithEditButton extends StatelessWidget {
  final String imageUrl;
  final File? localImage;
  final double width;
  final double height;

  const ProfileAvatarWithEditButton({
    super.key,
    required this.imageUrl,
    this.localImage,
    this.width = 160,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider avatarImage;

    // Prioritaskan gambar lokal jika ada
    if (localImage != null) {
      avatarImage = FileImage(localImage!);
    } else if (imageUrl.isNotEmpty &&
        (imageUrl.endsWith('.jpg') || imageUrl.endsWith('.jpeg') || imageUrl.endsWith('.png'))) {
      avatarImage = NetworkImage(imageUrl);
    } else {
      avatarImage = const NetworkImage(
        'https://static.vecteezy.com/system/resources/thumbnails/013/360/247/small_2x/default-avatar-photo-icon-social-media-profile-sign-symbol-vector.jpg',
      );
    }


    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ThemeApp.greenSoft,
              width: 4,
            ),
          ),
          child: CircleAvatar(
            radius: width / 2,
            backgroundImage: avatarImage,
            backgroundColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
