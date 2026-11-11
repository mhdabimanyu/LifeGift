import 'package:flutter/material.dart';

import '../theme/responsive.dart';
import 'blood_test_screen.dart';
import 'consult_screen.dart';
import 'donor_map_screen.dart';
import 'home_screen.dart';
import 'organ_pledge_screen.dart';
import 'profile_screen.dart';

/// Kerangka navigasi utama (5 tab: Beranda, Donor, Organ, Konsul, Profil).
///
/// [Ketentuan 1] Scaffold dengan bottomNavigationBar.
/// [Ketentuan 7] Adaptive navigation:
///   - lebar < 720  -> NavigationBar di bawah (ponsel portrait)
///   - lebar >= 720 -> NavigationRail di kiri (landscape / tablet)
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _Dest {
  const _Dest(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class _AppShellState extends State<AppShell> {
  static const double _railBreakpoint = 720;

  static const List<_Dest> _dests = [
    _Dest('Beranda', Icons.home_outlined, Icons.home),
    _Dest('Donor', Icons.bloodtype_outlined, Icons.bloodtype),
    _Dest('Organ', Icons.volunteer_activism_outlined, Icons.volunteer_activism),
    _Dest('Konsul', Icons.chat_bubble_outline, Icons.chat_bubble),
    _Dest('Profil', Icons.person_outline, Icons.person),
  ];

  int _index = 0;

  void _select(int i) => setState(() => _index = i);

  void _openBloodTest() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const BloodTestScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Semua tab dipertahankan state-nya dengan IndexedStack.
    final Widget pages = IndexedStack(
      index: _index,
      children: [
        HomeScreen(onSelectTab: _select, onOpenBloodTest: _openBloodTest),
        const DonorMapScreen(),
        const OrganPledgeScreen(),
        const ConsultScreen(),
        const ProfileScreen(),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useRail = constraints.maxWidth >= _railBreakpoint;
        final bool shortScreen = constraints.maxHeight < 480;
        // Breakpoints dipakai juga di sini agar konsisten dengan layar lain.
        final ScreenSize size = Breakpoints.fromWidth(constraints.maxWidth);

        return Scaffold(
          body: useRail
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _index,
                      onDestinationSelected: _select,
                      // Layar landscape pendek: sembunyikan label agar tidak overflow.
                      labelType: shortScreen
                          ? NavigationRailLabelType.none
                          : NavigationRailLabelType.all,
                      extended: false,
                      minWidth: size == ScreenSize.expanded ? 88 : 72,
                      destinations: [
                        for (final _Dest d in _dests)
                          NavigationRailDestination(
                            icon: Icon(d.icon),
                            selectedIcon: Icon(d.selectedIcon),
                            label: Text(d.label),
                          ),
                      ],
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: pages),
                  ],
                )
              : pages,
          bottomNavigationBar: useRail
              ? null
              : NavigationBar(
                  selectedIndex: _index,
                  onDestinationSelected: _select,
                  destinations: [
                    for (final _Dest d in _dests)
                      NavigationDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: d.label,
                      ),
                  ],
                ),
        );
      },
    );
  }
}
