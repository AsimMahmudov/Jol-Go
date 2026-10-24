import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textPrimary,
      secondary: AppColors.dark,
      onSecondary: AppColors.textOnDark,
      error: AppColors.danger,
      onError: AppColors.textOnDark,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),

    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.h1,
      headlineSmall: AppTextStyles.h2,
      titleMedium: AppTextStyles.title,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
      labelLarge: AppTextStyles.button,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: AppColors.primary,
      indicatorShape: const StadiumBorder(),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: AppColors.textPrimary, size: 24),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        return AppTextStyles.body.copyWith(
          fontSize: 11,
          color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        );
      }),
    ),
  );
}
