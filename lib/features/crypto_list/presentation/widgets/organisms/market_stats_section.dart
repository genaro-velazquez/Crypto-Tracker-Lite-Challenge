import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
//import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/info_row.dart';
import 'package:flutter/material.dart';

class MarketStatsSection extends StatelessWidget {
  final CryptoEntity crypto;

  const MarketStatsSection({super.key, required this.crypto});

  String _formatNumber(double? number) {
    if (number == null) return 'N/A';
    if (number >= 1000000000) {
      return '\$${(number / 1000000000).toStringAsFixed(2)}B';
    }
    if (number >= 1000000) {
      return '\$${(number / 1000000).toStringAsFixed(2)}M';
    }
    return '\$${number.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
        children: [
          // Tarjeta 1: Máximo 24h
          _StatCard(
            icon: Icons.trending_up,
            iconColor: AppColors.positive,
            label: 'Máximo 24h',
            value: '\$${crypto.high24h.toStringAsFixed(2)}',
          ),
          // Tarjeta 2: Mínimo 24h
          _StatCard(
            icon: Icons.trending_down,
            iconColor: AppColors.negative,
            label: 'Mínimo 24h',
            value: '\$${crypto.low24h.toStringAsFixed(2)}',
          ),
          // Tarjeta 3: Capitalización
          _StatCard(
            icon: Icons.wallet_giftcard,
            iconColor: AppColors.primary,
            label: 'Capitalización',
            value: _formatNumber(crypto.marketCap),
          ),
          // Tarjeta 4: Volumen 24h
          _StatCard(
            icon: Icons.swap_horiz,
            iconColor: AppColors.gold,
            label: 'Volumen 24h',
            value: _formatNumber(
              crypto.marketCap,
            ), // Placeholder (no está en entity)
          ),
        ],
      ),
    );
  }
}

// Widget para cada tarjeta
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fila 1: Icono + Título
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 8),
              CustomText(
                label,
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Fila 2: Valor
          CustomText(
            value,
            style: AppTextStyles.labelLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}



/*
class MarketStatsSection extends StatelessWidget {
  final CryptoEntity crypto;

  const MarketStatsSection({
    super.key,
    required this.crypto,
  });

  String _formatNumber(double? number) {
    if (number == null) return 'N/A';
    if (number >= 1000000000) {
      return '\$${(number / 1000000000).toStringAsFixed(2)}B';
    }
    if (number >= 1000000) {
      return '\$${(number / 1000000).toStringAsFixed(2)}M';
    }
    return '\$${number.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Estadísticas de Mercado',
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: 16),
          InfoRow(
            label: 'Precio Actual',
            value: '\$${crypto.currentPrice.toStringAsFixed(2)}',
          ),
          InfoRow(
            label: 'Alto 24h',
            value: '\$${crypto.high24h.toStringAsFixed(2)}',
          ),
          InfoRow(
            label: 'Bajo 24h',
            value: '\$${crypto.low24h.toStringAsFixed(2)}',
          ),
          InfoRow(
            label: 'Cambio 24h',
            value: '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
          ),
          const SizedBox(height: 12),
          InfoRow(
            label: 'Market Cap',
            value: _formatNumber(crypto.marketCap),
          ),
          InfoRow(
            label: 'Rank',
            value: '#${crypto.marketCapRank ?? 'N/A'}',
          ),
        ],
      ),
    );
  }
}
*/