


import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/crypto_image.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/favorite_button.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/price_info.dart';
import 'package:flutter/material.dart';

class CryptoDetailHeader extends StatelessWidget {
  final CryptoEntity crypto;
  final VoidCallback onFavoriteTap;

  const CryptoDetailHeader({
    super.key,
    required this.crypto,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Imagen + Favorito
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CryptoImage(imageUrl: crypto.image, size: 60),
              FavoriteButton(
                isFavorite: crypto.isFavorite,
                onPressed: onFavoriteTap,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Nombre + Símbolo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                crypto.name,
                style: AppTextStyles.displaySmall,
              ),
              CustomText(
                crypto.symbol.toUpperCase(),
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Precio + Cambio
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceInfo(
                currentPrice: crypto.currentPrice,
                changePercentage: crypto.priceChangePercentage24h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
