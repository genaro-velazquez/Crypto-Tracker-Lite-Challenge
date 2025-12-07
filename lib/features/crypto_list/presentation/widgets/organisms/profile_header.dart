import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeader({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          // Avatar con borde amarillo
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceColor,
              border: Border.all(color: AppColors.gold, width: 4),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Nombre
          CustomText(name, style: AppTextStyles.displaySmall),
          const SizedBox(height: 8),
          // Email con icono
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email, color: AppColors.primary, size: 18),
              const SizedBox(width: 6),
              CustomText(email, style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
