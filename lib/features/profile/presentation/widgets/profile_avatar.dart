import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/profile_controller.dart';

class ProfileAvatarView extends StatelessWidget {
  const ProfileAvatarView({
    super.key,
    required this.size,
    this.showCamera = false,
    this.onTap,
  });

  final double size;
  final bool showCamera;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final badge = size * 0.29;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(() {
              final path = c.profilePhotoPath.value;
              final file = File(path);
              final hasFile = path.isNotEmpty && file.existsSync();
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.burgundy50, width: 3),
                  image: DecorationImage(
                    image: hasFile
                        ? FileImage(file)
                        : const AssetImage(ImagePath.profileAvatar)
                              as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
            if (showCamera)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: badge,
                  height: badge,
                  decoration: BoxDecoration(
                    color: AppColors.maroonAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: badge * 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
