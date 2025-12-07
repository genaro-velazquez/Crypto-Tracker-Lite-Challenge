
import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/profile_info_item.dart';
import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String name;
  final String email;

  const ProfileInfoSection({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Nombre (Icono Azul)
          ProfileInfoItem(
            icon: Icons.person,
            label: 'Nombre',
            value: name,
            iconColor: AppColors.primary,
            iconBackgroundColor: AppColors.primary.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          // Item Email (Icono Naranja)
          ProfileInfoItem(
            icon: Icons.email,
            label: 'Correo',
            value: email,
            iconColor: Colors.orange,
            iconBackgroundColor: Colors.orange.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }
}
