import 'package:flutter/material.dart';

/// Warm semantic color system for a calm, single-focus experience.
///
/// Color communicates role rather than decoration: orange moves work forward,
/// near-black holds evidence and decisions, orange restores direction, green
/// marks maintenance or success, and gray keeps parked work quiet.
abstract final class AppColors {
  static const canvas = Color(0xFFF7F5F2);
  static const canvasDeep = Color(0xFFEFECE8);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceSecondary = Color(0xFFF2EFEB);
  static const surfaceWarm = Color(0xFFF8DCCF);
  static const surfacePressed = Color(0xFFE8E4DF);

  static const textPrimary = Color(0xFF171717);
  static const textSecondary = Color(0xFF5D5652);
  static const textTertiary = Color(0xFF6B645F);
  static const textInverse = Color(0xFFFFFFFF);

  static const border = Color(0xFFDEDAD4);
  static const controlBorder = Color(0xFF827A74);
  static const divider = Color(0xFFE7E3DE);

  static const action = Color(0xFFF25926);
  static const onAction = Color(0xFF171717);
  static const actionPressed = Color(0xFFDF5122);
  static const actionDeep = Color(0xFFB63812);
  static const actionSoft = Color(0xFFF8DCCF);

  static const evidence = Color(0xFF171717);
  static const onEvidence = Color(0xFFFFFFFF);
  static const evidenceMuted = Color(0xFFC9C2BC);

  // Compatibility aliases while presentation modules migrate to role names.
  static const accent = action;
  static const accentDeep = actionDeep;
  static const accentSoft = actionSoft;

  static const success = Color(0xFF087A55);
  static const successSoft = Color(0xFFE6F6EF);
  static const maintenance = success;
  static const maintenanceSoft = successSoft;

  static const parking = Color(0xFF625D59);
  static const parkingSoft = Color(0xFFECE9E5);

  static const warning = Color(0xFF8A5700);
  static const warningSoft = Color(0xFFFFF2D1);
  static const danger = Color(0xFFB42318);
  static const dangerSoft = Color(0xFFFDECEA);

  static const guide = actionDeep;
  static const guideDeep = actionDeep;
  static const guideSoft = actionSoft;
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
  static const spacious = 48.0;
}

abstract final class AppRadius {
  static const small = 10.0;
  static const input = 16.0;
  static const button = 18.0;
  static const card = 22.0;
  static const hero = 24.0;
  static const navigation = 24.0;
  static const sheet = 28.0;
}

abstract final class AppDuration {
  static const tap = Duration(milliseconds: 120);
  static const stateChange = Duration(milliseconds: 210);
  static const card = Duration(milliseconds: 280);
  static const sheet = Duration(milliseconds: 340);
  static const success = Duration(milliseconds: 560);
}

abstract final class AppMotion {
  static AnimationStyle sheet(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return AnimationStyle(
      duration: reduceMotion ? Duration.zero : AppDuration.sheet,
      reverseDuration: reduceMotion ? Duration.zero : AppDuration.card,
    );
  }
}

abstract final class AppShadows {
  static const card = [
    BoxShadow(color: Color(0x0D3B2E28), blurRadius: 18, offset: Offset(0, 8)),
  ];

  static const floating = [
    BoxShadow(color: Color(0x143B2E28), blurRadius: 28, offset: Offset(0, 12)),
  ];

  static const focus = [
    BoxShadow(color: Color(0x24F25926), blurRadius: 28, offset: Offset(0, 14)),
  ];
}

abstract final class AppTextStyles {
  static const eyebrow = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  static const number = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w700,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}

abstract final class AppTheme {
  static ThemeData light() {
    const colorScheme = ColorScheme.light(
      primary: AppColors.action,
      onPrimary: AppColors.onAction,
      primaryContainer: AppColors.actionSoft,
      onPrimaryContainer: AppColors.textPrimary,
      secondary: AppColors.guide,
      onSecondary: AppColors.textInverse,
      secondaryContainer: AppColors.guideSoft,
      onSecondaryContainer: AppColors.textPrimary,
      error: AppColors.danger,
      onError: AppColors.textInverse,
      errorContainer: AppColors.dangerSoft,
      onErrorContainer: AppColors.textPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerLowest: AppColors.surface,
      surfaceContainerLow: AppColors.canvas,
      surfaceContainer: AppColors.surfaceSecondary,
      surfaceContainerHigh: AppColors.canvasDeep,
      outline: AppColors.controlBorder,
      outlineVariant: AppColors.divider,
    );

    final textTheme =
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            height: 44 / 40,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.3,
          ),
          displayMedium: TextStyle(
            fontSize: 36,
            height: 41 / 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
          ),
          headlineLarge: TextStyle(
            fontSize: 31,
            height: 36 / 31,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            height: 30 / 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
          titleLarge: TextStyle(
            fontSize: 19,
            height: 25 / 19,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(fontSize: 17, height: 25 / 17),
          bodyMedium: TextStyle(fontSize: 15, height: 22 / 15),
          labelLarge: TextStyle(
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w700,
          ),
          labelMedium: TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(fontSize: 12, height: 17 / 12),
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
      materialTapTargetSize: MaterialTapTargetSize.padded,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.canvas,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 64,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 17,
          height: 22 / 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.card)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          animationDuration: AppDuration.tap,
          minimumSize: const WidgetStatePropertyAll(Size(44, 56)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppSpacing.generous),
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.border;
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.actionPressed;
            }
            return AppColors.action;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textTertiary;
            }
            return AppColors.onAction;
          }),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          animationDuration: AppDuration.tap,
          minimumSize: const WidgetStatePropertyAll(Size(44, 54)),
          foregroundColor: const WidgetStatePropertyAll(AppColors.textPrimary),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.surfacePressed;
            }
            return AppColors.surface;
          }),
          side: const WidgetStatePropertyAll(
            BorderSide(color: AppColors.controlBorder),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.actionDeep,
          minimumSize: const Size(44, 44),
          textStyle: textTheme.labelMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size.square(44),
          foregroundColor: AppColors.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.action
                : AppColors.textTertiary,
            size: 23,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return textTheme.bodySmall?.copyWith(
            color: states.contains(WidgetState.selected)
                ? AppColors.actionDeep
                : AppColors.textTertiary,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.standard,
          vertical: AppSpacing.standard,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textTertiary,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
          borderSide: BorderSide(color: AppColors.controlBorder),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
          borderSide: BorderSide(color: AppColors.controlBorder),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
          borderSide: BorderSide(color: AppColors.action, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
          borderSide: BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
          borderSide: BorderSide(color: AppColors.danger, width: 1.5),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.action;
          return Colors.transparent;
        }),
        side: const BorderSide(color: AppColors.textTertiary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceSecondary,
        selectedColor: AppColors.actionSoft,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        labelStyle: textTheme.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.compact),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: AppColors.border,
        dragHandleSize: Size(42, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.hero)),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: TextStyle(color: AppColors.textInverse),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.input)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.action,
        linearTrackColor: AppColors.surfaceSecondary,
        circularTrackColor: AppColors.surfaceSecondary,
      ),
    );
  }
}
