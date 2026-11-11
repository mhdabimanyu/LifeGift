import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const LifeGiftApp());
}

/// Root aplikasi LifeGift.
/// [Ketentuan 4] Material 3 diaktifkan lewat [AppTheme.light] (useMaterial3).
class LifeGiftApp extends StatelessWidget {
  const LifeGiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeGift',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const SplashScreen(),
    );
  }
}
