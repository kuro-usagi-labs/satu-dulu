import 'package:flutter/material.dart';

abstract final class AppColors {
  static const canvas = Color(0xFFF6F7F9);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceSecondary = Color(0xFFF0F2F5);
  static const textPrimary = Color(0xFF111318);
  static const textSecondary = Color(0xFF676D78);
  static const textTertiary = Color(0xFF9298A3);
  static const border = Color(0xFFE7E9EE);
  static const divider = Color(0xFFECEEF2);
  static const accent = Color(0xFF4468F2);
  static const accentSoft = Color(0xFFEEF2FF);
  static const success = Color(0xFF1F9D68);
  static const successSoft = Color(0xFFEAF8F1);
  static const warning = Color(0xFFC98512);
  static const warningSoft = Color(0xFFFFF6DF);
  static const danger = Color(0xFFD84A4A);
  static const dangerSoft = Color(0xFFFFF0F0);
  static const guide = Color(0xFF7157D9);
  static const guideSoft = Color(0xFFF2EFFF);
}

abstract final class AppSpacing {
  static const micro = 4.0;
  static const compact = 8.0;
  static const innerCompact = 12.0;
  static const standard = 16.0;
  static const generous = 20.0;
  static const section = 24.0;
  static const major = 32.0;
  static const screen = 40.0;
}

abstract final class AppRadius {
  static const small = 12.0;
  static const input = 14.0;
  static const button = 16.0;
  static const card = 20.0;
  static const hero = 24.0;
  static const sheet = 28.0;
}

abstract final class AppDuration {
  static const tap = Duration(milliseconds: 120);
  static const stateChange = Duration(milliseconds: 200);
  static const card = Duration(milliseconds: 260);
  static const sheet = Duration(milliseconds: 320);
  static const success = Duration(milliseconds: 520);
}

abstract final class AppShadows {
  static const card = [
    BoxShadow(color: Color(0x0A111318), blurRadius: 2, offset: Offset(0, 1)),
    BoxShadow(color: Color(0x0A111318), blurRadius: 24, offset: Offset(0, 8)),
  ];
}

abstract final class AppTheme {
  static ThemeData light() {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: Brightness.light,
          surface: AppColors.surface,
        ).copyWith(
          primary: AppColors.accent,
          onPrimary: Colors.white,
          secondary: AppColors.guide,
          error: AppColors.danger,
          outline: AppColors.border,
          surfaceContainer: AppColors.surfaceSecondary,
        );

    final textTheme =
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 34,
            height: 40 / 34,
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: TextStyle(
            fontSize: 28,
            height: 34 / 28,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontSize: 22,
            height: 28 / 22,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            height: 24 / 18,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(fontSize: 17, height: 24 / 17),
          bodyMedium: TextStyle(fontSize: 15, height: 22 / 15),
          labelLarge: TextStyle(
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(fontSize: 12, height: 16 / 12),
        ).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.canvas,
      textTheme: textTheme,
      dividerColor: AppColors.divider,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.canvas,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.card)),
          side: BorderSide(color: AppColors.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.accentSoft,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
