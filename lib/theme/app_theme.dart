import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static const Color _seed = Color(0xFF6750A4);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final ColorScheme scheme =
        ColorScheme.fromSeed(seedColor: _seed, brightness: brightness).copyWith(
          surface: isDark ? const Color(0xFF12111F) : const Color(0xFFF7F5FF),
          surfaceContainerLow: isDark ? const Color(0xFF1F1D36) : Colors.white,
          primary: isDark ? const Color(0xFF7C6BFF) : const Color(0xFF5B4BFF),
          onPrimary: Colors.white,
          onSurface: isDark ? const Color(0xFFF2F0FF) : const Color(0xFF1A1A2E),
          onSurfaceVariant: isDark
              ? const Color(0xFFA9A7C4)
              : const Color(0xFF6B6A85),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      extensions: [isDark ? AppColors.dark : AppColors.light],

      // الشريط العلوي
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),

      // الكروت: بدون ظل، حدود ناعمة، وزوايا دائرية
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        margin: const EdgeInsets.only(bottom: 14),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),

      // عناصر القوايم جوه الكروت (التصنيفات والكلمات)
      listTileTheme: ListTileThemeData(
        iconColor: scheme.primary,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 15,
          color: scheme.onSurfaceVariant,
        ),
      ),

      // زرار "Show Translation"
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // زرار النطق
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
      ),

      // شريط التنقل السفلي
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
