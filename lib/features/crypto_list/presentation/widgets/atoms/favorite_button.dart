

import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite; 
  final VoidCallback onPressed;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        isFavorite ? Icons.star : Icons.star_outline,
        color: isFavorite ? AppColors.gold : AppColors.textSecondary,
        size: 24,
      ),
    );
  }
}