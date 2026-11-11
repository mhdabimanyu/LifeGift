import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';

/// LAYAR 08 - Cek Golongan Darah / Pesan Tes Laboratorium (slide 17).
///
/// [Ketentuan 1] Scaffold + AppBar.
/// [Ketentuan 3] Text, Icon, RichText, reusable widget.
/// [Ketentuan 5] Container, Padding, SizedBox.
/// [Ketentuan 6] ListView (lab), Wrap + Expanded (jadwal), Column, Row.
/// [Ketentuan 7] Wrap otomatis membungkus chip jadwal sesuai lebar layar.
class BloodTestScreen extends StatefulWidget {
  const BloodTestScreen({super.key});

  @override
  State<BloodTestScreen> createState() => _BloodTestScreenState();
}

class _BloodTestScreenState extends State<BloodTestScreen> {
  int _labIndex = 0;
  int _slotIndex = 1;

  Future<void> _book() async {
    final LabOption lab = DummyData.labs[_labIndex];
    final String slot = DummyData.labSchedules[_slotIndex];
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.event_available, color: AppColors.success),
        title: const Text('Pemesanan Dikonfirmasi'),
        content: Text('${lab.name}\n$slot \u00B7 ${lab.priceLabel}'),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(100, 44)),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Golongan Darah')),
      body: SingleChildScrollView(
        child: ResponsiveBody(
          maxWidth: 560,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Pesan tes di lab terdekat'),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DummyData.labs.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: Spacing.sm + 2),
                itemBuilder: (context, i) {
                  final LabOption lab = DummyData.labs[i];
                  final bool selected = i == _labIndex;
                  return InfoCard(
                    onTap: () => setState(() => _labIndex = i),
                    color: selected ? AppColors.roseSoft : Colors.white,
                    borderColor: selected ? AppColors.rose : AppColors.line,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(lab.name, style: text.titleMedium),
                              Text(
                                '${lab.distanceKm.toString().replaceAll('.', ',')} km',
                                style: text.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          lab.priceLabel,
                          style: text.titleMedium?.copyWith(
                            color: AppColors.crimson,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: Spacing.lg),
              const SectionTitle('Pilih jadwal'),
              Wrap(
                spacing: Spacing.sm + 2,
                runSpacing: Spacing.sm + 2,
                children: [
                  for (int i = 0; i < DummyData.labSchedules.length; i++)
                    ChoiceChip(
                      label: Text(DummyData.labSchedules[i]),
                      selected: i == _slotIndex,
                      selectedColor: AppColors.roseTint,
                      onSelected: (_) => setState(() => _slotIndex = i),
                    ),
                ],
              ),
              const SizedBox(height: Spacing.lg),
              // Panduan kecocokan donor-resipien (fitur slide 7).
              InfoCard(
                padding: EdgeInsets.zero,
                child: ExpansionTile(
                  shape: const Border(),
                  collapsedShape: const Border(),
                  leading: const Icon(
                    Icons.swap_horiz,
                    color: AppColors.crimson,
                  ),
                  title: Text(
                    'Panduan kecocokan donor-resipien',
                    style: text.titleMedium,
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(
                    Spacing.md,
                    0,
                    Spacing.md,
                    Spacing.md,
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: text.bodyMedium,
                        children: [
                          const TextSpan(text: 'Golongan Anda '),
                          TextSpan(
                            text: DummyData.userBloodType,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.crimson,
                            ),
                          ),
                          const TextSpan(
                            text:
                                ' dapat mendonorkan darah ke O+, A+, B+, '
                                'dan AB+. Hasil tes lab tetap menjadi acuan resmi.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.xl),
              PrimaryActionButton(
                label: 'Pesan Tes Sekarang',
                icon: Icons.science,
                onPressed: _book,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
