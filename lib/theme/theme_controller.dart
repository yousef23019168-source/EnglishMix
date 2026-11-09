// lib/theme/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.system);
  static const _key = 'theme_mode';

  static Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    mode.value = ThemeMode.values[p.getInt(_key) ?? 0];
  }

  static Future<void> set(ThemeMode m) async {
    mode.value = m;
    final p = await SharedPreferences.getInstance();
    await p.setInt(_key, m.index);
  }
}
