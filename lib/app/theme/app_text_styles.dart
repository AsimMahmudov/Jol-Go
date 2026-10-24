import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // «Куда едем?»
  static const h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  // «Популярные направления», «Выберите места», время «07:30»
  static const h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // «Toyota Alphard · белый», «Бишкек → Ош»
  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Обычный текст
  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // «Азамат · ★ 4.9», «в пути ~ 10 ч»
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Текст на кнопках
  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
}
