

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  final String? description;

  const DescriptionSection({
    super.key,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Remover HTML tags si existen
    String cleanDescription = description!
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .trim();

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
            'Descripción',
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: 12),
          Text(
            cleanDescription,
            style: AppTextStyles.bodySmall,
            maxLines: null,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
