

import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class PriceText extends StatelessWidget{
  final double price; 

  const PriceText(
    {
      super.key,
      required this.price,
    }
  );
  
  @override
  Widget build(BuildContext context) {
    return CustomText('\$${price.toStringAsFixed(2)}', style: AppTextStyles.labelLarge);
  }

}