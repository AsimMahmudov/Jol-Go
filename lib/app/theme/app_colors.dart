import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Основные
  static const primary = Color(0xFFFFC531); // жёлтый: кнопки, аватары
  static const dark = Color(0xFF16171D); // шапка, чёрная кнопка, активный чип

  // Фоны
  static const background = Color(0xFFF2F3F5); // серый фон экрана
  static const surface = Color(0xFFFFFFFF); // белые карточки

  // Текст
  static const textPrimary = Color(0xFF16171D);
  static const textSecondary = Color(0xFF8E8E93); // «~ 4 ч», «Ошская область»
  static const textOnDark = Color(0xFFFFFFFF);

  // Линии
  static const border = Color(0xFFE6E7EB);

  // Статусы
  static const seatTaken = Color(0xFFE5383B); // занятое место
  static const danger = Color(0xFFD92D20); // «Удалить аккаунт»
  static const warningBg = Color(0xFFFFF4D6); // фон «Ожидает подтверждения»
  static const warningText = Color(0xFFA86B00);

  static const successBg = Color(0xFFE3F5E8);    // фон «Подтверждена»
  static const successText = Color(0xFF1E8E3E);
}
