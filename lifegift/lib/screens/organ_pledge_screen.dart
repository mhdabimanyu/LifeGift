import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';
import 'donor_card_screen.dart';

/// LAYAR 06 - Registrasi Ikrar Donor Organ (slide 15).
///
/// [Ketentuan 1] Scaffold + AppBar (judul + langkah).
/// [Ketentuan 3] Icon, Text, reusable widget.
/// [Ketentuan 5] Padding, SizedBox, Container.
/// [Ketentuan 6] GridView (pilihan organ), Column, Row, Expanded.
/// [Ketentuan 7] Jumlah kolom grid organ mengikuti lebar (2 -> 3 -> 6).
class OrganPledgeScreen extends StatefulWidget {
  const OrganPledgeScreen({super.key});

  @override
  State<OrganPledgeScreen> createState() => _OrganPledgeScreenState();
}

class _OrganPledgeScreenState extends State<OrganPledgeScreen> {
  final Set<String> _selected = {'Ginjal', 'Hati', 'Kornea'};
  bool _ktpUploaded = true;
  bool _consentUploaded = false;

  bool get _canSubmit =>
      _selected.isNotEmpty && _ktpUploaded && _consentUploaded;

  void _toggleOrgan(String organ) {
    setState(() {
      if (!_selected.add(organ)) _selected.remove(organ);
    });
  }

  Future<void> _submit() async {
    final bool? viewCard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.hourglass_top, color: AppColors.rose),
        title: const Text('Dikirim untuk Verifikasi'),
        content: const Text(
          'Dokumen Anda sedang diverifikasi tim admin. Untuk prototipe, '
          'Anda dapat melihat contoh kartu donor digital yang sudah terverifikasi.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Tutup'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(120, 44)),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Lihat Kartu Donor'),
          ),
        ],
      ),
    );
    if (viewCard == true && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DonorCardScreen(organs: _selected.toList()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ikrar Donor Organ'),
            Text(
              'Langkah 2 dari 3',
              style: text.bodyMedium?.copyWith(color: AppColors.roseBorder),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Kartu donor digital',
            icon: const Icon(Icons.badge_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => DonorCardScreen(organs: _selected.toList()),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveBody(
          maxWidth: 720,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress langkah.
              ClipRRect(
                borderRadius: BorderRadius.circular(Radii.sm),
                child: const LinearProgressIndicator(
                  value: 2 / 3,
                  minHeight: 8,
                  color: AppColors.rose,
                  backgroundColor: AppColors.roseTint,
                ),
              ),
              const SizedBox(height: Spacing.lg),
              const SectionTitle('Pilih organ yang bersedia didonorkan'),
              LayoutBuilder(
                builder: (context, constraints) {
                  final int cols = constraints.maxWidth >= 640
                      ? 6
                      : (constraints.maxWidth >= 420 ? 3 : 2);
                  return GridView.count(
                    crossAxisCount: cols,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: Spacing.sm + 2,
                    crossAxisSpacing: Spacing.sm + 2,
                    childAspectRatio: cols == 6 ? 1.1 : 2.4,
                    children: [
                      for (final String organ in DummyData.organs)
                        _OrganChoice(
                          label: organ,
                          selected: _selected.contains(organ),
                          onTap: () => _toggleOrgan(organ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: Spacing.lg),
              const SectionTitle('Dokumen pendukung'),
              _UploadTile(
                title: 'KTP',
                uploaded: _ktpUploaded,
                onTap: () => setState(() => _ktpUploaded = !_ktpUploaded),
              ),
              const SizedBox(height: Spacing.sm),
              _UploadTile(
                title: 'Persetujuan keluarga',
                uploaded: _consentUploaded,
                onTap: () =>
                    setState(() => _consentUploaded = !_consentUploaded),
              ),
              const SizedBox(height: Spacing.xl),
              PrimaryActionButton(
                label: 'Kirim untuk Verifikasi',
                onPressed: _canSubmit ? _submit : null,
              ),
              if (!_canSubmit)
                Padding(
                  padding: const EdgeInsets.only(top: Spacing.sm),
                  child: Text(
                    'Pilih minimal satu organ dan unggah kedua dokumen.',
                    style: text.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrganChoice extends StatelessWidget {
  const _OrganChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      onTap: onTap,
      color: selected ? AppColors.roseSoft : Colors.white,
      borderColor: selected ? AppColors.rose : AppColors.line,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.sm),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(Icons.check, size: 18, color: AppColors.crimson),
              const SizedBox(width: Spacing.xs),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: selected ? AppColors.crimson : AppColors.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadTile extends StatelessWidget {
  const _UploadTile({
    required this.title,
    required this.uploaded,
    required this.onTap,
  });

  final String title;
  final bool uploaded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return InfoCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            uploaded ? Icons.check_circle : Icons.upload_file,
            color: uploaded ? AppColors.success : AppColors.slate,
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Text(
              uploaded ? '$title (terunggah)' : '$title (ketuk untuk unggah)',
              style: text.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
