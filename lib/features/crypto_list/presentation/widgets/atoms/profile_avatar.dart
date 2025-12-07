

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double size;
  final IconData icon;

  const ProfileAvatar({
    super.key,
    this.size = 120,
    this.icon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceColor,
        border: Border.all(
          color: AppColors.primary,
          width: 3,
        ),
      ),
      child: Icon(
        icon,
        size: size * 0.5,
        color: AppColors.primary,
      ),
    );
  }
}

