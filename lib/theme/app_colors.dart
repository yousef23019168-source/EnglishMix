import 'package:flutter/material.dart';

import '../models/category.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final List<Color> greetings, intro, howAreYou, ending; // [from, to]
  final List<Color> daily, education, food; // [from, to]
  final Color chipBg, trackBg;

  const AppColors({
    required this.greetings,
    required this.intro,
    required this.howAreYou,
    required this.ending,
    required this.daily,
    required this.education,
    required this.food,
    required this.chipBg,
    required this.trackBg,
  });

  static const light = AppColors(
    greetings: [Color(0xFFFF7A7A), Color(0xFFFF4D6D)],
    intro: [Color(0xFF34D3B6), Color(0xFF12A594)],
    howAreYou: [Color(0xFFFFC84A), Color(0xFFFF9F1C)],
    ending: [Color(0xFF8B7BFF), Color(0xFF5B4BFF)],
    daily: [Color(0xFF4FACFE), Color(0xFF2563EB)],
    education: [Color(0xFFF472B6), Color(0xFFDB2777)],
    food: [Color(0xFFA3E635), Color(0xFF65A30D)],
    chipBg: Color(0xFFE7E3FF),
    trackBg: Color(0xFFE3DEFF),
  );

  static const dark = AppColors(
    greetings: [Color(0xFFE8586B), Color(0xFFC92F52)],
    intro: [Color(0xFF1FB59B), Color(0xFF0B8577)],
    howAreYou: [Color(0xFFE0A92E), Color(0xFFD4811A)],
    ending: [Color(0xFF7C6BFF), Color(0xFF4B3BE0)],
    daily: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    education: [Color(0xFFD9468F), Color(0xFFB01E66)],
    food: [Color(0xFF84CC16), Color(0xFF4D7C0F)],
    chipBg: Color(0xFF2B2850),
    trackBg: Color(0xFF2E2B50),
  );

  /// لون كل تصنيف رئيسي [from, to]
  List<Color> gradientFor(Category? c) => switch (c) {
    Category.greetings => greetings,
    Category.introductions => intro,
    Category.howAreYou => howAreYou,
    Category.endingAndStarting => ending,
    Category.daily => daily,
    Category.education => education,
    Category.food => food,
    null => ending,
  };

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) =>
      other is AppColors ? (t < 0.5 ? this : other) : this;
}
