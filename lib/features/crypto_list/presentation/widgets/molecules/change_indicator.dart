

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/percentage_text.dart';
import 'package:flutter/material.dart';

class ChangeIndicator extends StatelessWidget {
  final double changePercentage;

  const ChangeIndicator({
    super.key,
    required this.changePercentage
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = changePercentage > 0;
    final iconColor = isPositive ? AppColors.positive : AppColors.negative;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: iconColor,
        ),
        const SizedBox(width: 4,),
        PercentageText(percentage: changePercentage)
      ],
    );


  }
}