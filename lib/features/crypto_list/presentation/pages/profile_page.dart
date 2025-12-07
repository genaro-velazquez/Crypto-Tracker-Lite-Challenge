

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/pages/favorites_page.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/info_item.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/navigation_item.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/stat_item.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/profile_header.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/profile_info_section.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/templates/profile_template.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
      title: 'Perfil',
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header (Organism)
            const ProfileHeader(
              name: 'Genaro Velázquez',
              email: 'genarovelazquez@hotmail.com',
            ),
            const SizedBox(height: 24),
            // Profile Info Section (Organism) - NUEVO
            const ProfileInfoSection(
              name: 'Genaro Velázquez',
              email: 'genarovelazquez@hotmail.com',
            ),
          ],
        ),
      ),
    );
  }
}


/*
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
      title: 'Perfil',
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header con foto, nombre y email
            const ProfileHeader(
              name: 'Genaro Velázquez',
              email: 'genarovelazquez@hotmail.com',
            ),
            const SizedBox(height: 24),
            // Navigation Items (Favoritos y Perfil)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Item Favoritos
                  NavigationItem(
                    icon: Icons.star,
                    title: 'Favoritos',
                    iconColor: AppColors.gold,
                    iconBackgroundColor: AppColors.gold.withValues(alpha: 0.2),
                    borderColor: AppColors.gold,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  // Item Perfil
                  NavigationItem(
                    icon: Icons.person,
                    title: 'Editar Perfil',
                    iconColor: AppColors.primary,
                    iconBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.2),
                    borderColor: AppColors.primary,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Editar perfil próximamente'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
*/