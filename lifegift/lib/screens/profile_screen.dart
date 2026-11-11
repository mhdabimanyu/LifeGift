import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';

/// LAYAR 10 - Profil, Riwayat & Badge (slide 19).
///
/// [Ketentuan 1] Scaffold + AppBar.
/// [Ketentuan 3] CircleAvatar (inisial), Text, RichText, Icon, reusable.
/// [Ketentuan 5] Container, Padding, SizedBox, Center, Align.
/// [Ketentuan 6] Stack (avatar + centang), Row/Expanded (statistik),
///               ListView horizontal (badge), Column (riwayat).
/// [Ketentuan 7] LayoutBuilder: 1 kolom (compact) -> 2 kolom (>= 700 dp).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Riwayat')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool wide = constraints.maxWidth >= 700;
          const Widget header = _ProfileHeader();
          const Widget stats = _StatsRow();
          const Widget badges = _BadgeList();
          const Widget history = _HistorySection();

          if (wide) {
            return SingleChildScrollView(
              child: ResponsiveBody(
                maxWidth: 960,
                padding: const EdgeInsets.all(Spacing.lg),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          header,
                          SizedBox(height: Spacing.lg),
                          stats,
                          SizedBox(height: Spacing.lg),
                          badges,
                        ],
                      ),
                    ),
                    SizedBox(width: Spacing.lg),
                    Expanded(child: history),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: ResponsiveBody(
              maxWidth: 560,
              child: const Column(
                children: [
                  header,
                  SizedBox(height: Spacing.lg),
                  stats,
                  SizedBox(height: Spacing.md),
                  badges,
                  SizedBox(height: Spacing.md),
                  history,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.rose,
                child: Text(
                  'A',
                  style: text.headlineMedium?.copyWith(color: Colors.white),
                ),
              ),
              const Positioned(
                right: -2,
                bottom: -2,
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.verified,
                    size: 20,
                    color: AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm + 4),
          Text(DummyData.userName, style: text.titleLarge),
          const SizedBox(height: Spacing.xs),
          RichText(
            text: TextSpan(
              style: text.bodyMedium,
              children: const [
                TextSpan(text: 'Golongan '),
                TextSpan(
                  text: DummyData.userBloodType,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.crimson,
                  ),
                ),
                TextSpan(text: ' \u00B7 Donor aktif'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: StatTile(value: '4', label: 'Kali donor'),
        ),
        SizedBox(width: Spacing.sm + 4),
        Expanded(
          child: StatTile(value: '12', label: 'Nyawa terbantu'),
        ),
        SizedBox(width: Spacing.sm + 4),
        Expanded(
          child: StatTile(value: '3', label: 'Badge'),
        ),
      ],
    );
  }
}

class _BadgeList extends StatelessWidget {
  const _BadgeList();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Badge kemanusiaan'),
        SizedBox(
          height: 104,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: DummyData.badges.length,
            separatorBuilder: (_, __) => const SizedBox(width: Spacing.sm + 4),
            itemBuilder: (context, i) {
              final DonorBadge b = DummyData.badges[i];
              return SizedBox(
                width: 132,
                child: InfoCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.roseTint,
                        child: Icon(
                          Icons.military_tech,
                          color: AppColors.crimson,
                        ),
                      ),
                      const SizedBox(height: Spacing.xs + 2),
                      Text(
                        b.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.labelLarge,
                      ),
                      Text(
                        b.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodyMedium?.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HistorySection extends StatelessWidget {
  const _HistorySection();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Riwayat donor'),
        for (final DonationRecord r in DummyData.history) ...[
          InfoCard(
            child: Row(
              children: [
                const Icon(Icons.water_drop, color: AppColors.rose),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: Text(
                    '${r.date} \u00B7 ${r.place}',
                    style: text.bodyLarge,
                  ),
                ),
                Text(
                  '${r.volumeMl} ml',
                  style: text.titleMedium?.copyWith(color: AppColors.crimson),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.sm),
        ],
        const SizedBox(height: Spacing.xs),
        InfoCard(
          color: AppColors.roseSoft,
          borderColor: AppColors.roseBorder,
          child: Row(
            children: [
              const Icon(Icons.alarm, color: AppColors.crimson),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: text.bodyMedium?.copyWith(color: AppColors.ink),
                    children: const [
                      TextSpan(text: 'Pengingat donor berikutnya: '),
                      TextSpan(
                        text: '12 Okt 2026',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.crimson,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
