

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CryptoImage extends StatelessWidget {
  final String? imageUrl; 
  final double size; 

  const CryptoImage({
    super.key,
    this.imageUrl,
    this.size = 40
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty){
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(size/2)
        ),
        child: Center(
          child: Icon(
            Icons.currency_bitcoin,
            size: size * 0.6,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(size/2),
      child: Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace){
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(size/2)
            ),
            child: Icon(
              Icons.error,
              size: size * 0.6,
            ),
          );
        },
      ),
    );
  }
}