

import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label; 
  final String value;

  const InfoRow({
    super.key,
    required this.label,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(label, style: AppTextStyles.bodySmall),
          CustomText(value, style: AppTextStyles.bodyMedium)
        ],
      ),
    );
  }
}