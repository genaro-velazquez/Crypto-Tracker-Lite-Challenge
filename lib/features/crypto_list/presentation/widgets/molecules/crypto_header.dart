

import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/crypto_image.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class CryptoHeader extends StatelessWidget {
  final String? imageUrl; 
  final String name; 
  final String symbol; 

  const CryptoHeader({
    super.key,
    this.imageUrl,
    required this.name,
    required this.symbol
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CryptoImage(imageUrl: imageUrl),
        const SizedBox(width: 12,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(name, style: AppTextStyles.labelLarge),
            CustomText(symbol.toLowerCase(), style: AppTextStyles.bodySmall)
          ],
        )
      ],
    );
  }
}