import 'package:flutter/material.dart';

/// ============================================================
/// [Ketentuan 4 - Material Design & UI Dasar]
/// Seluruh warna, spacing, radius, dan typography LifeGift
/// didefinisikan di satu tempat (design token) agar konsisten.
/// Palet diambil dari desain UI pada slide proposal (slide 10-19).
/// ============================================================
class AppColors {
  AppColors._();

  static const Color rose = Color(0xFFE11D48); // aksi utama
  static const Color crimson = Color(0xFF9F1239);
  static const Color burgundy = Color(0xFF881337); // app bar & hero
  static const Color roseSoft = Color(0xFFFFF1F2);
  static const Color roseTint = Color(0xFFFFE4E6);
  static const Color roseBorder = Color(0xFFFECDD3);
  static const Color rosePale = Color(0xFFFDA4AF);

  static const Color ink = Color(0xFF0F172A); // teks utama
  static const Color slate = Color(0xFF475569); // teks sekunder
  static const Color line = Color(0xFFE2E8F0); // border/divider
  static const Color canvas = Color(0xFFF8FAFC); // background layar

  static const Color success = Color(0xFF15803D);
  static const Color successSoft = Color(0xFFDCFCE7);
  static const Color mapWater = Color(0xFFE0F2FE);
  static const Color info = Color(0xFF0284C7);
}

/// Skala spacing berbasis kelipatan 4 (grid 4dp).
class Spacing {
  Spacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

/// Skala radius sudut.
class Radii {
  Radii._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;

  static BorderRadius get card => BorderRadius.circular(md);
  static BorderRadius get panel => BorderRadius.circular(lg);
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    // Material 3: ColorScheme dibangkitkan dari seed, lalu ditimpa
    // pada warna kunci supaya sama persis dengan desain slide.
    final ColorScheme scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.rose,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.rose,
          onPrimary: Colors.white,
          secondary: AppColors.burgundy,
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: AppColors.ink,
          error: AppColors.crimson,
        );

    final ThemeData base = ThemeData(useMaterial3: true, colorScheme: scheme);

    // Typography: hierarchy jelas (display > headline > title > body > label).
    final TextTheme text = base.textTheme
        .apply(bodyColor: AppColors.ink, displayColor: AppColors.ink)
        .copyWith(
          headlineMedium: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
          headlineSmall: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
          titleMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          bodyLarge: const TextStyle(fontSize: 16, height: 1.45),
          bodyMedium: const TextStyle(
            fontSize: 14,
            height: 1.45,
            color: AppColors.slate,
          ),
          labelLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
          labelSmall: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        );

    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Radii.md),
      borderSide: const BorderSide(color: AppColors.line),
    );

    return base.copyWith(
      textTheme: text,
      scaffoldBackgroundColor: AppColors.canvas,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.burgundy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge?.copyWith(color: Colors.white),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: Radii.card),
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: AppColors.rose,
          side: const BorderSide(color: AppColors.rose, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: Radii.card),
          textStyle: text.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.md,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.rose, width: 2),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.crimson),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.crimson, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.roseTint,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final bool selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppColors.crimson : AppColors.slate,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final bool selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppColors.crimson : AppColors.slate,
          );
        }),
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.roseTint,
        selectedIconTheme: IconThemeData(color: AppColors.crimson),
        unselectedIconTheme: IconThemeData(color: AppColors.slate),
        selectedLabelTextStyle: TextStyle(
          color: AppColors.crimson,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: TextStyle(color: AppColors.slate),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
