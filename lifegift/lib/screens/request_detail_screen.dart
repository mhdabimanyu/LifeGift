import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';

/// LAYAR 05 - Detail & Respon Darurat (slide 14).
///
/// [Ketentuan 1] Scaffold + AppBar.
/// [Ketentuan 3] RichText (info pasien & kelayakan), Icon, Text.
/// [Ketentuan 5] Container, Padding, SizedBox, Center.
/// [Ketentuan 6] Row + Expanded (3 info), Column.
class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({super.key, required this.request});

  final BloodRequest request;

  Future<void> _confirm(BuildContext context) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.favorite, color: AppColors.rose),
        title: const Text('Saya Bersedia Mendonor?'),
        content: Text(
          'Kesediaan Anda akan dikirim ke ${request.hospital}. '
          'Mohon datang sebelum batas waktu ${request.deadlineHours} jam.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(100, 44)),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Ya, Bersedia'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      showInfoSnack(context, 'Terima kasih! Kesediaan Anda telah dikirim.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final String distance =
        '${request.distanceKm.toString().replaceAll('.', ',')} km';

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Permintaan')),
      body: SingleChildScrollView(
        child: ResponsiveBody(
          maxWidth: 560,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chip status darurat.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm + 4,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.rose,
                  borderRadius: BorderRadius.circular(Radii.xl),
                ),
                child: Text(
                  'DARURAT',
                  style: text.labelSmall?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: Spacing.sm + 4),
              Text(request.hospital, style: text.headlineSmall),
              const SizedBox(height: Spacing.xs),
              RichText(
                text: TextSpan(
                  style: text.bodyLarge?.copyWith(color: AppColors.slate),
                  children: [
                    const TextSpan(text: 'Pasien: '),
                    TextSpan(
                      text: request.patient,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const TextSpan(text: ' \u00B7 Kebutuhan '),
                    TextSpan(
                      text: '${request.unitsNeeded} kantong',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.crimson,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _InfoBox(
                      label: 'Golongan',
                      value: request.bloodType,
                    ),
                  ),
                  const SizedBox(width: Spacing.sm + 4),
                  Expanded(
                    child: _InfoBox(label: 'Jarak', value: distance),
                  ),
                  const SizedBox(width: Spacing.sm + 4),
                  Expanded(
                    child: _InfoBox(
                      label: 'Batas waktu',
                      value: '${request.deadlineHours} jam',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),
              // Cek kelayakan otomatis.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.successSoft,
                  borderRadius: Radii.card,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: Spacing.sm + 4),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: text.bodyMedium?.copyWith(
                            color: AppColors.ink,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Cek kelayakan otomatis\n',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: 'Usia 17-60, berat \u2265 45 kg, donor terakhir > 3 bulan lalu ',
                            ),
                            TextSpan(
                              text: '\u2713 Memenuhi syarat',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.xl),
              PrimaryActionButton(
                label: 'Saya Bersedia Mendonor',
                icon: Icons.favorite,
                onPressed: () => _confirm(context),
              ),
              const SizedBox(height: Spacing.sm + 4),
              SecondaryActionButton(
                label: 'Buka Rute di Peta',
                icon: Icons.directions,
                onPressed: () => showInfoSnack(
                  context,
                  'Rute ke ${request.hospital} (butuh Google Maps).',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Spacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          Text(label, style: text.bodyMedium),
          const SizedBox(height: Spacing.xs),
          Text(
            value,
            style: text.titleMedium?.copyWith(color: AppColors.crimson),
          ),
        ],
      ),
    );
  }
}
