import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/pages/favorites_page.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/pages/profile_page.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/drawer_item.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onFavoritesReturn;

  const AppDrawer({super.key, this.onFavoritesReturn});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.secondaryBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header del Drawer
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              border: Border(bottom: BorderSide(color: AppColors.borderColor)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Avatar con borde amarillo
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryBackground,
                    border: Border.all(color: AppColors.gold, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Nombre
                CustomText('Genaro Velázquez', style: AppTextStyles.labelLarge),
                // Email con icono
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // ← AGREGA
                  children: [
                    Icon(Icons.email, color: AppColors.primary, size: 14),
                    const SizedBox(width: 6),
                    CustomText(
                      'genarovelazquez@hotmail.com',
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Separador
          const SizedBox(height: 8),
          // Items de navegación
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                // Item Favoritos
                DrawerItem(
                  icon: Icons.star,
                  title: 'Favoritos',
                  iconColor: AppColors.gold,
                  iconBackgroundColor: AppColors.gold.withValues(alpha: 0.2),
                  borderColor: AppColors.gold,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesPage(),
                      ),
                    ).then((_) {
                      // Ejecutar callback cuando regresa
                      onFavoritesReturn?.call();
                    });
                  },
                ),
                const SizedBox(height: 8),
                // Item Perfil
                DrawerItem(
                  icon: Icons.person,
                  title: 'Perfil',
                  iconColor: AppColors.primary,
                  iconBackgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  borderColor: AppColors.primary,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.borderColor,
            height: 24,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
