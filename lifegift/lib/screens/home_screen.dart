import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';
import 'request_detail_screen.dart';

/// LAYAR 03 - Home Dashboard (slide 12).
///
/// [Ketentuan 1] Scaffold + AppBar.
/// [Ketentuan 3] Text, RichText, Icon, CircleAvatar, Image (via widget).
/// [Ketentuan 5] Container, Padding, SizedBox, Align.
/// [Ketentuan 6] Stack (kartu donor), Row/Column/Expanded,
///               CarouselView (banner darurat), GridView (menu 4 modul),
///               ListView (scroll utama).
/// [Ketentuan 7] LayoutBuilder: 1 kolom (compact) -> 2 kolom (expanded);
///               jumlah kolom grid menu menyesuaikan lebar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onSelectTab,
    required this.onOpenBloodTest,
  });

  final ValueChanged<int> onSelectTab;
  final VoidCallback onOpenBloodTest;

  void _openDetail(BuildContext context, BloodRequest r) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => RequestDetailScreen(request: r)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: _Greeting(),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () =>
                showInfoSnack(context, 'Belum ada notifikasi baru.'),
            icon: const Icon(Icons.notifications_none),
          ),
          Padding(
            padding: const EdgeInsets.only(right: Spacing.md),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(color: AppColors.burgundy),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final ScreenSize size = Breakpoints.fromWidth(constraints.maxWidth);
          final Widget summary = _SummaryColumn(
            onOpenDetail: (r) => _openDetail(context, r),
            width: constraints.maxWidth,
          );
          final Widget menu = _QuickMenu(
            onSelectTab: onSelectTab,
            onOpenBloodTest: onOpenBloodTest,
            columns: size == ScreenSize.compact
                ? 2
                : (size == ScreenSize.medium ? 4 : 2),
          );

          // Expanded: dua kolom (ringkasan | menu cepat).
          if (size == ScreenSize.expanded) {
            return Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: ListView(children: [summary])),
                  const SizedBox(width: Spacing.lg),
                  Expanded(flex: 4, child: ListView(children: [menu])),
                ],
              ),
            );
          }

          // Compact / medium: satu kolom yang discroll.
          return ListView(
            padding: const EdgeInsets.all(Spacing.md),
            children: [
              summary,
              const SizedBox(height: Spacing.md),
              menu,
            ],
          );
        },
      ),
    );
  }
}

/// Sapaan: RichText dengan dua gaya pada satu paragraf.
class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: text.titleLarge?.copyWith(color: Colors.white),
            children: const [
              TextSpan(text: 'Halo, '),
              TextSpan(
                text: DummyData.userFirstName,
                style: TextStyle(color: AppColors.rosePale),
              ),
              TextSpan(text: ' \u{1F44B}'),
            ],
          ),
        ),
        Text(
          'Siap menolong hari ini?',
          style: text.bodyMedium?.copyWith(color: AppColors.roseBorder),
        ),
      ],
    );
  }
}

class _SummaryColumn extends StatelessWidget {
  const _SummaryColumn({required this.onOpenDetail, required this.width});

  final ValueChanged<BloodRequest> onOpenDetail;
  final double width;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    // Lebar item carousel mengikuti lebar layar (maks 320).
    final double itemExtent = (width * 0.8).clamp(240.0, 320.0).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Kartu Donor Anda'),
        const _DonorSummaryCard(),
        const SizedBox(height: Spacing.md),
        // Banner peringatan dengan RichText.
        Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: AppColors.roseSoft,
            borderRadius: Radii.card,
            border: Border.all(color: AppColors.roseBorder),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.rose),
              const SizedBox(width: Spacing.sm),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: text.bodyMedium,
                    children: [
                      TextSpan(
                        text: '${DummyData.requests.length} permintaan darurat',
                        style: text.titleMedium?.copyWith(
                          color: AppColors.crimson,
                        ),
                      ),
                      const TextSpan(text: ' dekatmu'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.sm),
        // Carousel permintaan darurat (geser horizontal).
        SizedBox(
          height: 104,
          child: CarouselView(
            itemExtent: itemExtent,
            shrinkExtent: 120,
            onTap: (i) => onOpenDetail(DummyData.requests[i]),
            children: [
              for (final BloodRequest r in DummyData.requests)
                _EmergencyCarouselItem(request: r),
            ],
          ),
        ),
      ],
    );
  }
}

/// Kartu donor ringkas: Stack (dekorasi lingkaran di belakang) + isi.
class _DonorSummaryCard extends StatelessWidget {
  const _DonorSummaryCard();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: Radii.panel,
      child: Container(
        color: AppColors.burgundy,
        child: Stack(
          children: [
            // Lapisan dekorasi.
            Positioned(
              right: -30,
              top: -30,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: AppColors.crimson,
              ),
            ),
            Positioned(
              right: 40,
              bottom: -40,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.crimson,
              ),
            ),
            // Lapisan isi.
            Padding(
              padding: const EdgeInsets.all(Spacing.lg - 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kartu Donor Anda',
                          style: text.bodyMedium?.copyWith(
                            color: AppColors.roseBorder,
                          ),
                        ),
                        Text(
                          DummyData.userBloodType,
                          style: text.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 44,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Donor ke-4',
                        style: text.titleMedium?.copyWith(color: Colors.white),
                      ),
                      Text(
                        'Terakhir 12 Jul',
                        style: text.bodyMedium?.copyWith(
                          color: AppColors.roseBorder,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyCarouselItem extends StatelessWidget {
  const _EmergencyCarouselItem({required this.request});

  final BloodRequest request;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.roseTint,
              child: Icon(Icons.local_hospital, color: AppColors.crimson),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Butuh golongan ${request.bloodType}',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: text.titleMedium,
                  ),
                  Text(
                    '${request.distanceKm.toString().replaceAll('.', ',')} km \u00B7 ${request.hospital}',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: text.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Menu cepat 4 modul (maks. 3 klik) memakai GridView.
class _QuickMenu extends StatelessWidget {
  const _QuickMenu({
    required this.onSelectTab,
    required this.onOpenBloodTest,
    required this.columns,
  });

  final ValueChanged<int> onSelectTab;
  final VoidCallback onOpenBloodTest;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Menu Cepat'),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: Spacing.sm + 4,
            crossAxisSpacing: Spacing.sm + 4,
            mainAxisExtent: 132, // tinggi tetap: aman untuk teks & ikon
          ),
          children: [
            FeatureTile(
              icon: Icons.bloodtype,
              title: 'Donor Darah',
              subtitle: 'Cari & respon',
              onTap: () => onSelectTab(1),
            ),
            FeatureTile(
              icon: Icons.volunteer_activism,
              title: 'Donor Organ',
              subtitle: 'Daftar ikrar',
              onTap: () => onSelectTab(2),
            ),
            FeatureTile(
              icon: Icons.science_outlined,
              title: 'Cek Darah',
              subtitle: 'Booking lab',
              onTap: onOpenBloodTest,
            ),
            FeatureTile(
              icon: Icons.chat_bubble_outline,
              title: 'Konsultasi',
              subtitle: 'Chat dokter',
              onTap: () => onSelectTab(3),
            ),
          ],
        ),
      ],
    );
  }
}
