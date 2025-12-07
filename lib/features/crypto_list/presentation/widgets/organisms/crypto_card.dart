import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/crypto_image.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/favorite_button.dart';
//import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/change_indicator.dart';
//import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/crypto_header.dart';
//import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/price_info.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String id;
  final String? imageUrl;
  final String name;
  final String symbol;
  final double currentPrice;
  final double changePercentage;
  final bool isFavorite;
  final VoidCallback onTap;
  final Future<void> Function() onFavoriteTap;

  const CryptoCard({
    super.key,
    required this.id,
    this.imageUrl,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.changePercentage,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = changePercentage > 0;
    final percentageColor = isPositive
        ? AppColors.positive
        : AppColors.negative;
    final arrow = isPositive ? '↑' : '↓';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            // Logo (Izquierda)
            CryptoImage(imageUrl: imageUrl, size: 50),
            const SizedBox(width: 12),

            // Nombre + Símbolo (Columna)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(name, style: AppTextStyles.labelLarge),
                CustomText(
                  symbol.toLowerCase(),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),

            // Espacio flexible
            const Spacer(),

            // Precio + Porcentaje (Columna derecha)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Precio
                CustomText(
                  '\$${currentPrice.toStringAsFixed(2)}',
                  style: AppTextStyles.labelLarge,
                ),
                // Porcentaje
                CustomText(
                  '${changePercentage.abs().toStringAsFixed(2)}%',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: percentageColor,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Corazón (Favorito)
            FavoriteButton(isFavorite: isFavorite, onPressed: onFavoriteTap),
          ],
        ),
      ),
    );
  }
}


/*
class CryptoCard extends StatelessWidget {
  final String id; 
  final String? imageUrl; 
  final String name; 
  final String symbol; 
  final double currentPrice;
  final double changePercentage; 
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const CryptoCard({
    super.key,
    required this.id,
    this.imageUrl,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.changePercentage,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CryptoHeader(imageUrl: imageUrl, name: name, symbol: symbol),
                  const SizedBox(height: 12,),
                  PriceInfo(currentPrice: currentPrice, changePercentage: changePercentage)
                ],
              )),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FavoriteButton(isFavorite: isFavorite, onPressed: onFavoriteTap),
                  const SizedBox(height: 12,),
                  ChangeIndicator(changePercentage: changePercentage)
                ],
              )
          ],
        ),
      ),
    );
  }
}
*/