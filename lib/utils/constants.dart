import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF666666);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color border = Color(0xFFE1E8ED);
  static const Color text = Color(0xFF000000);
  static const Color like = Color(0xFFE0245E);
  static const Color repost = Color(0xFF17BF63);
  static const Color reply = Color(0xFF1DA1F2);
  static const Color verified = Color(0xFF1DA1F2);
}

class AppSizes {
  static const double padding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double avatarSize = 40.0;
  static const double largeAvatarSize = 60.0;
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.primary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: AppColors.secondary,
  );

  static const TextStyle small = TextStyle(
    fontSize: 12,
    color: AppColors.secondary,
  );
}
