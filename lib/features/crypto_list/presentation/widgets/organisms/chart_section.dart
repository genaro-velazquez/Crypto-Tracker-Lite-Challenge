import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/market_data_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  final MarketDataEntity chartData;
  final String cryptoName;

  const ChartSection({
    super.key,
    required this.chartData,
    required this.cryptoName,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.prices.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomText(
          'Sin datos de gráfico',
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    // Encontrar min y max
    final minPrice = chartData.prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = chartData.prices.reduce((a, b) => a > b ? a : b);
    final range = maxPrice - minPrice;

    // Crear spots
    List<FlSpot> spots = [];
    for (int i = 0; i < chartData.prices.length; i++) {
      final normalizedPrice = (chartData.prices[i] - minPrice) / range * 100;
      spots.add(FlSpot(i.toDouble(), normalizedPrice));
    }

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
            'Últimos 7 días',
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'Mín: \$${minPrice.toStringAsFixed(2)}',
                style: AppTextStyles.bodySmall,
              ),
              CustomText(
                'Máx: \$${maxPrice.toStringAsFixed(2)}',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
