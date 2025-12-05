

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class PercentageText extends StatelessWidget {
  final double percentage; 

  const PercentageText(
    {
      super.key,
      required this.percentage
    }
  );

  @override
  Widget build(BuildContext context) {
    final isPositive = percentage > 0;
    final color = isPositive ? AppColors.positive : AppColors.negative;
    final sign = isPositive ? '+' : '-';

    return CustomText(
      '$sign${percentage.toStringAsFixed(2)}%', 
      style: AppTextStyles.bodySmall.copyWith(color: color));


  }
}