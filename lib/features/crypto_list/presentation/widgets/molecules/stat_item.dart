

import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class StatItem extends StatelessWidget {
  final String value;
  final String label;

  const StatItem({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          value,
          style: AppTextStyles.displaySmall,
        ),
        const SizedBox(height: 8),
        CustomText(
          label,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
