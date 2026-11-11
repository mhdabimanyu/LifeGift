import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';

/// LAYAR 07 - Kartu Donor Digital (slide 16).
///
/// [Ketentuan 1] Scaffold + AppBar.
/// [Ketentuan 3] Text, RichText, Icon, reusable FakeQrCode.
/// [Ketentuan 5] Container, Padding, SizedBox, Align.
/// [Ketentuan 6] Stack, Row, Column, Expanded.
/// [Ketentuan 7] OrientationBuilder: landscape = kartu | aksi berdampingan.
class DonorCardScreen extends StatelessWidget {
  const DonorCardScreen({
    super.key,
    this.organs = const ['Ginjal', 'Hati', 'Kornea'],
  });

  final List<String> organs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kartu Donor Digital')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final Widget card = _DonorCard(organs: organs);
          final Widget actions = _CardActions();

          if (orientation == Orientation.landscape) {
            return Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: SingleChildScrollView(child: card)),
                  const SizedBox(width: Spacing.lg),
                  Expanded(child: SingleChildScrollView(child: actions)),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: ResponsiveBody(
              maxWidth: 480,
              child: Column(
                children: [
                  card,
                  const SizedBox(height: Spacing.md),
                  actions,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DonorCard extends StatelessWidget {
  const _DonorCard({required this.organs});

  final List<String> organs;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final TextStyle detail = text.bodyMedium!.copyWith(
      color: AppColors.roseBorder,
    );

    return ClipRRect(
      borderRadius: Radii.panel,
      child: Container(
        color: AppColors.burgundy,
        padding: const EdgeInsets.all(Spacing.lg - 4),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: AppColors.rosePale,
                      size: 16,
                    ),
                    const SizedBox(width: Spacing.xs + 2),
                    Text(
                      'LifeGift \u00B7 Donor Organ',
                      style: text.labelLarge?.copyWith(
                        color: AppColors.rosePale,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.lg),
                Text(
                  DummyData.userName,
                  style: text.headlineSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: Spacing.sm),
                // Baris rincian memakai RichText agar label & nilai
                // berbeda gaya dalam satu paragraf.
                _detail('Gol. darah: ', DummyData.userBloodType, detail),
                _detail(
                  'Organ: ',
                  organs.isEmpty ? '-' : organs.join(', '),
                  detail,
                ),
                _detail('No. Reg: ', DummyData.registrationNo, detail),
                const SizedBox(height: Spacing.lg + Spacing.sm),
                const SizedBox(width: double.infinity),
              ],
            ),
            // QR di pojok kanan bawah kartu.
            const Positioned(
              right: 0,
              bottom: 0,
              child: FakeQrCode(data: DummyData.registrationNo, size: 104),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(String label, String value, TextStyle base) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xs, right: 112),
      child: RichText(
        text: TextSpan(
          style: base,
          children: [
            TextSpan(text: label),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.sm + 4,
              vertical: Spacing.xs + 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.successSoft,
              borderRadius: BorderRadius.circular(Radii.xl),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, size: 16, color: AppColors.success),
                const SizedBox(width: Spacing.xs + 2),
                Text(
                  'Terverifikasi',
                  style: text.labelLarge?.copyWith(color: AppColors.success),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Spacing.sm + 4),
        Text(
          'Tunjukkan QR ini kepada faskes untuk memverifikasi status donor Anda.',
          style: text.bodyMedium,
        ),
        const SizedBox(height: Spacing.lg),
        PrimaryActionButton(
          label: 'Simpan ke Galeri',
          icon: Icons.download,
          onPressed: () =>
              showInfoSnack(context, 'Kartu disimpan ke galeri (simulasi).'),
        ),
        const SizedBox(height: Spacing.sm + 4),
        SecondaryActionButton(
          label: 'Bagikan ke Keluarga',
          icon: Icons.share,
          onPressed: () =>
              showInfoSnack(context, 'Menu bagikan dibuka (simulasi).'),
        ),
      ],
    );
  }
}
