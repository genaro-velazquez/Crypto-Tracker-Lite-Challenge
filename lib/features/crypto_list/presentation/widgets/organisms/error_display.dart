

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback onRetry; 
  final bool isRateLimit;

  const ErrorDisplay({
    super.key,
    required this.message,
    required this.onRetry,
    this.isRateLimit = false
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isRateLimit ? Icons.schedule : Icons.error_outline,
              size: 64,
              color: isRateLimit ? AppColors.warning : AppColors.negative,
            ),
            const SizedBox(height: 16,),
            CustomText(message, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center,),
            const SizedBox(height: 24,),
            ElevatedButton(onPressed: onRetry, child: const Text('Reintentar'))
          ],
        ),
      ),
    );
  }
}