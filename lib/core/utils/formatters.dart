import 'package:flutter/material.dart';

class Formatters {
  Formatters._();

  static const _months = [
    'янв',
    'фев',
    'мар',
    'апр',
    'мая',
    'июн',
    'июл',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек',
  ];

  static const _weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

  static const _monthsFull = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ];

  static String shortDate(DateTime date) {
    return '${date.day} ${_months[date.month - 1]}';
  }

  static String weekdayDay(DateTime date) {
    return '${_weekdays[date.weekday - 1]}, ${date.day}';
  }

  static String plural(int n, String one, String few, String many) {
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 == 1 && mod100 != 11) return one;
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return few;
    return many;
  }

  static String time(DateTime date) {
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  static String price(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('\u00A0');
      buffer.write(digits[i]);
    }
    return '$buffer\u00A0сом';
  }

  static String relativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    final diff = day.difference(today).inDays;
    final full = '${date.day} ${_monthsFull[date.month - 1]}';

    if (diff == 0) return 'Сегодня, $full';
    if (diff == 1) return 'Завтра, $full';
    return '${_weekdays[date.weekday - 1]}, $full';
  }

  static String notificationTime(DateTime date) {
    return DateUtils.isSameDay(date, DateTime.now())
        ? time(date)
        : shortDate(date);
  }

  static String tripDateTime(DateTime date) {
    return '${_weekdays[date.weekday - 1]}, ${shortDate(date)} · ${time(date)}';
  }
}
