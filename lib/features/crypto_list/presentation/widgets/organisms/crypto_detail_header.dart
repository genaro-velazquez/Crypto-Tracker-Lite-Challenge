


import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/crypto_image.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';


class CryptoDetailHeader extends StatelessWidget {
  final CryptoEntity crypto;

  const CryptoDetailHeader({
    super.key,
    required this.crypto,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = crypto.priceChangePercentage24h > 0;
    final percentageColor =
        isPositive ? AppColors.positive : AppColors.negative;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila 1: Logo + Nombre + Símbolo
          Row(
            children: [
              // Logo
              CryptoImage(imageUrl: crypto.image, size: 60),
              const SizedBox(width: 16),
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
            ],
          ),
          const SizedBox(height: 20),

          // Fila 2: Label "Precio actual"
          CustomText(
            'Precio actual',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 8),

          // Fila 3: Precio + Porcentaje en box
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Precio
              CustomText(
                '\$${crypto.currentPrice.toStringAsFixed(2)}',
                style: AppTextStyles.displayLarge,
              ),
              // Porcentaje en box con borde
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: percentageColor.withValues(alpha: 0.15),
                  border: Border.all(
                    color: percentageColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      crypto.priceChangePercentage24h > 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: percentageColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      '${crypto.priceChangePercentage24h.abs().toStringAsFixed(2)}%',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: percentageColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
