import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'request_detail_screen.dart';

/// LAYAR 04 - Peta Donor Darurat (slide 13).
///
/// [Ketentuan 1] Scaffold + AppBar (judul 2 baris).
/// [Ketentuan 5] Align/Alignment, Container, Padding, SizedBox.
/// [Ketentuan 6] Stack (peta + penanda), Positioned, Expanded,
///               ListView (daftar permintaan), horizontal ListView (filter).
/// [Ketentuan 7] OrientationBuilder: portrait = peta di atas, daftar di bawah;
///               landscape = peta dan daftar berdampingan (Row).
class DonorMapScreen extends StatefulWidget {
  const DonorMapScreen({super.key});

  @override
  State<DonorMapScreen> createState() => _DonorMapScreenState();
}

class _DonorMapScreenState extends State<DonorMapScreen> {
  String _bloodFilter = 'Semua';
  double _radiusKm = 5;
  BloodRequest? _selected;

  List<BloodRequest> get _filtered => DummyData.requests.where((r) {
    final bool typeOk = _bloodFilter == 'Semua' || r.bloodType == _bloodFilter;
    return typeOk && r.distanceKm <= _radiusKm;
  }).toList();

  void _openDetail(BloodRequest r) {
    setState(() => _selected = r);
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => RequestDetailScreen(request: r)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Donor Darurat'),
            Text(
              'Sekitar Medan \u00B7 radius ${_radiusKm.round()} km',
              style: text.bodyMedium?.copyWith(color: AppColors.roseBorder),
            ),
          ],
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final List<BloodRequest> items = _filtered;
          final Widget map = _MapPanel(
            requests: items,
            selected: _selected,
            onMarkerTap: _openDetail,
          );
          final Widget list = _RequestPanel(
            items: items,
            selected: _selected,
            bloodFilter: _bloodFilter,
            radiusKm: _radiusKm,
            onFilterChanged: (v) => setState(() => _bloodFilter = v),
            onRadiusChanged: (v) => setState(() => _radiusKm = v),
            onTapItem: _openDetail,
          );

          if (orientation == Orientation.landscape) {
            return Row(
              children: [
                Expanded(flex: 5, child: map),
                Expanded(flex: 4, child: list),
              ],
            );
          }
          return Column(
            children: [
              SizedBox(height: 240, child: map),
              Expanded(child: list),
            ],
          );
        },
      ),
    );
  }
}

/// Peta ilustrasi. Penanda diposisikan dengan [Align] + [Alignment]
/// sehingga selalu proporsional berapa pun ukuran panelnya.
class _MapPanel extends StatelessWidget {
  const _MapPanel({
    required this.requests,
    required this.selected,
    required this.onMarkerTap,
  });

  final List<BloodRequest> requests;
  final BloodRequest? selected;
  final ValueChanged<BloodRequest> onMarkerTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: AppColors.mapWater),
            // "Jalan" ilustrasi.
            Align(
              alignment: const Alignment(0, 0.1),
              child: Container(
                height: 10,
                width: constraints.maxWidth,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: const Alignment(-0.1, 0),
              child: Container(
                width: 10,
                height: constraints.maxHeight,
                color: Colors.white,
              ),
            ),
            // Posisi pengguna.
            const Align(
              alignment: Alignment(0.05, 0.15),
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.white,
                child: CircleAvatar(radius: 6, backgroundColor: AppColors.info),
              ),
            ),
            // Penanda permintaan darurat.
            for (final BloodRequest r in requests)
              Align(
                alignment: Alignment(r.mapX, r.mapY),
                child: Tooltip(
                  message: '${r.hospital} (${r.bloodType})',
                  child: GestureDetector(
                    onTap: () => onMarkerTap(r),
                    child: Icon(
                      Icons.location_on,
                      size: identical(r, selected) ? 44 : 36,
                      color: AppColors.rose,
                    ),
                  ),
                ),
              ),
            // Info jumlah di pojok.
            Positioned(
              left: Spacing.sm,
              top: Spacing.sm,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm + 2,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Radii.xl),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.my_location,
                      size: 14,
                      color: AppColors.info,
                    ),
                    const SizedBox(width: Spacing.xs),
                    Text(
                      '${requests.length} permintaan',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RequestPanel extends StatelessWidget {
  const _RequestPanel({
    required this.items,
    required this.selected,
    required this.bloodFilter,
    required this.radiusKm,
    required this.onFilterChanged,
    required this.onRadiusChanged,
    required this.onTapItem,
  });

  final List<BloodRequest> items;
  final BloodRequest? selected;
  final String bloodFilter;
  final double radiusKm;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<double> onRadiusChanged;
  final ValueChanged<BloodRequest> onTapItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.md),
      children: [
        // Filter golongan darah.
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: DummyData.bloodTypeFilters.length,
            separatorBuilder: (_, __) => const SizedBox(width: Spacing.sm),
            itemBuilder: (context, i) {
              final String f = DummyData.bloodTypeFilters[i];
              return ChoiceChip(
                label: Text(f),
                selected: bloodFilter == f,
                selectedColor: AppColors.roseTint,
                onSelected: (_) => onFilterChanged(f),
              );
            },
          ),
        ),
        const SizedBox(height: Spacing.sm),
        // Filter jarak.
        Row(
          children: [
            const Icon(Icons.social_distance, color: AppColors.slate),
            Expanded(
              child: Slider(
                value: radiusKm,
                min: 3,
                max: 10,
                divisions: 7,
                label: '${radiusKm.round()} km',
                onChanged: onRadiusChanged,
              ),
            ),
            Text(
              '${radiusKm.round()} km',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SectionTitle('Daftar permintaan terdekat'),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.all(Spacing.lg),
            child: Center(child: Text('Tidak ada permintaan sesuai filter.')),
          ),
        for (final BloodRequest r in items) ...[
          RequestTile(
            request: r,
            highlighted: identical(r, selected),
            onTap: () => onTapItem(r),
          ),
          const SizedBox(height: Spacing.sm + 2),
        ],
      ],
    );
  }
}
