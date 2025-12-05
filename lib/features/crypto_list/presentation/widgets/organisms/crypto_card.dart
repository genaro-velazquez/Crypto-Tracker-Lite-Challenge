
import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/favorite_button.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/change_indicator.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/crypto_header.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/price_info.dart';
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