

import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class LoadingDisplay extends StatelessWidget {
  final String message; 

  const LoadingDisplay({
    super.key,
    this.message = "Cargando..."
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16,),
          CustomText(message, style: AppTextStyles.bodyMedium)
        ],
      ),
    );
  }
}