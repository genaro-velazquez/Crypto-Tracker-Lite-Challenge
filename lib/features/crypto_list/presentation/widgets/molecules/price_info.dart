

import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/percentage_text.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/price_text.dart';
import 'package:flutter/material.dart';

class PriceInfo extends StatelessWidget { 
  final double currentPrice; 
  final double changePercentage;

  const PriceInfo({
    super.key,
    required this.currentPrice,
    required this.changePercentage
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PriceText(price: currentPrice,),
        const SizedBox(height: 4,),
        PercentageText(percentage: changePercentage)
      ],
    );
  }
}