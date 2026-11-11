import 'package:flutter/material.dart';

import 'app_theme.dart';

/// ============================================================
/// [Ketentuan 7 - Responsive & Adaptive UI]
/// Breakpoint mengikuti pedoman window size class Material 3:
///   compact  < 600   (ponsel portrait)
///   medium   < 900   (ponsel landscape / tablet kecil)
///   expanded >= 900  (tablet / desktop)
/// ============================================================
enum ScreenSize { compact, medium, expanded }

class Breakpoints {
  Breakpoints._();

  static const double medium = 600;
  static const double expanded = 900;

  /// Menentukan kelas layar dari LEBAR YANG TERSEDIA (constraint),
  /// bukan lebar perangkat, sehingga widget tetap benar saat dipakai
  /// di dalam panel yang lebih sempit dari layar.
  static ScreenSize fromWidth(double width) {
    if (width >= expanded) return ScreenSize.expanded;
    if (width >= medium) return ScreenSize.medium;
    return ScreenSize.compact;
  }
}

/// Membatasi lebar konten agar tetap nyaman dibaca di layar lebar,
/// dan memusatkannya (Align + ConstrainedBox).
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({
    super.key,
    required this.child,
    this.maxWidth = 640,
    this.padding = const EdgeInsets.all(Spacing.md),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
