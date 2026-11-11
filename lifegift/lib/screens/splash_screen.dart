import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';
import 'app_shell.dart';
import 'register_screen.dart';

/// LAYAR 01 - Splash & Selamat Datang (slide 10).
///
/// [Ketentuan 1] Scaffold dengan backgroundColor + body.
/// [Ketentuan 7] OrientationBuilder: portrait = Column, landscape = Row.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _goHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const AppShell()),
    );
  }

  void _goRegister(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.burgundy,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final Widget brand = _Brand(
              compact: orientation == Orientation.landscape,
            );
            final Widget actions = _Actions(
              onLogin: () => _goHome(context),
              onRegister: () => _goRegister(context),
              onGoogle: () => showInfoSnack(
                context,
                'Login Google akan terhubung pada tahap integrasi.',
              ),
            );

            if (orientation == Orientation.landscape) {
              // Landscape: logo di kiri, tombol di kanan.
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Row(
                      children: [
                        Expanded(child: brand),
                        const SizedBox(width: Spacing.xl),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Center(child: actions),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Portrait: logo di tengah, tombol di bawah.
            return ResponsiveBody(
              maxWidth: 480,
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                children: [
                  Expanded(child: brand),
                  actions,
                  const SizedBox(height: Spacing.md),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LifeGiftLogo(size: compact ? 96 : 140),
            const SizedBox(height: Spacing.lg),
            Text(
              'LifeGift',
              style: text.headlineMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              'Connecting Hearts, Saving Lives',
              textAlign: TextAlign.center,
              style: text.bodyLarge?.copyWith(
                color: AppColors.rosePale,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.onLogin,
    required this.onRegister,
    required this.onGoogle,
  });

  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final VoidCallback onGoogle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryActionButton(label: 'Masuk', onDark: true, onPressed: onLogin),
        const SizedBox(height: Spacing.md - 4),
        PrimaryActionButton(label: 'Daftar Akun Baru', onPressed: onRegister),
        const SizedBox(height: Spacing.sm),
        TextButton.icon(
          onPressed: onGoogle,
          style: TextButton.styleFrom(foregroundColor: AppColors.rosePale),
          icon: const Icon(Icons.login),
          label: const Text('Login cepat Google atau email'),
        ),
      ],
    );
  }
}
