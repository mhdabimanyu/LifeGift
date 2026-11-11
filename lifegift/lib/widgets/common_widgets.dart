import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';

/// ============================================================
/// [Ketentuan 3 - Flutter UI Components: Reusable Widget]
/// Kumpulan widget yang dipakai berulang di banyak layar.
/// Setiap widget menerima data lewat constructor (stateless)
/// sehingga mudah diuji dan dipakai ulang.
/// ============================================================

/// Menampilkan SnackBar singkat.
void showInfoSnack(BuildContext context, String message) {
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Logo LifeGift: komponen [Image] (aset lokal) di dalam [CircleAvatar].
class LifeGiftLogo extends StatelessWidget {
  const LifeGiftLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: Image.asset(
          'assets/images/logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          // Jika aset gagal dimuat, tampilkan ikon sebagai pengganti.
          errorBuilder: (context, error, stack) =>
              Icon(Icons.favorite, color: AppColors.rose, size: size * 0.5),
        ),
      ),
    );
  }
}

/// Lencana golongan darah (mis. "O+").
class BloodTypeBadge extends StatelessWidget {
  const BloodTypeBadge({super.key, required this.label, this.large = false});

  final String label;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? Spacing.md : Spacing.sm + 2,
        vertical: large ? Spacing.sm : Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.roseTint,
        borderRadius: BorderRadius.circular(Radii.xl),
      ),
      child: Text(
        label,
        style: (large ? text.titleMedium : text.labelLarge)?.copyWith(
          color: AppColors.crimson,
        ),
      ),
    );
  }
}

/// Judul bagian dengan aksi opsional di kanan.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.sm, bottom: Spacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Kartu putih berborder tipis (surface dasar aplikasi).
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.borderColor = AppColors.line,
    this.padding = const EdgeInsets.all(Spacing.md),
    this.onTap,
  });

  final Widget child;
  final Color color;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: Radii.card,
        side: BorderSide(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Kotak statistik angka + label (mis. "4 / Kali donor").
class StatTile extends StatelessWidget {
  const StatTile({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.md,
        horizontal: Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.roseSoft,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.roseBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: text.headlineSmall?.copyWith(color: AppColors.crimson),
          ),
          const SizedBox(height: Spacing.xs),
          Text(label, textAlign: TextAlign.center, style: text.bodyMedium),
        ],
      ),
    );
  }
}

/// Menu cepat pada beranda (ikon + judul + subjudul).
class FeatureTile extends StatelessWidget {
  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return InfoCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.rose,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: text.titleMedium,
          ),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: text.bodyMedium,
          ),
        ],
      ),
    );
  }
}

/// Baris permintaan darurat: nama RS, jarak, dan lencana golongan.
class RequestTile extends StatelessWidget {
  const RequestTile({
    super.key,
    required this.request,
    required this.onTap,
    this.highlighted = false,
  });

  final BloodRequest request;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return InfoCard(
      onTap: onTap,
      color: highlighted ? AppColors.roseSoft : Colors.white,
      borderColor: highlighted ? AppColors.rose : AppColors.line,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.roseTint,
            child: Icon(Icons.local_hospital, color: AppColors.crimson),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.hospital,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleMedium,
                ),
                Text(
                  '${request.distanceKm.toString().replaceAll('.', ',')} km',
                  style: text.bodyMedium,
                ),
              ],
            ),
          ),
          BloodTypeBadge(label: request.bloodType),
        ],
      ),
    );
  }
}

/// Tombol aksi utama (FilledButton Material 3) dengan ikon opsional.
class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.onDark = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// true: tombol putih untuk latar gelap (splash).
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? style = onDark
        ? FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.burgundy,
          )
        : null;
    if (icon == null) {
      return FilledButton(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      );
    }
    return FilledButton.icon(
      onPressed: onPressed,
      style: style,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

/// Tombol sekunder (OutlinedButton) dengan ikon opsional.
class SecondaryActionButton extends StatelessWidget {
  const SecondaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return OutlinedButton(onPressed: onPressed, child: Text(label));
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

/// Label di atas isi form (hierarchy: label kecil, isi besar).
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xs + 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge
            ?.copyWith(color: AppColors.slate),
      ),
    );
  }
}

/// Ilustrasi QR Code (pola deterministik dari string), dibuat dengan
/// [GridView]. Hanya untuk prototipe UI; bukan QR yang valid dipindai.
/// Pada tahap integrasi diganti paket `qr_flutter`.
class FakeQrCode extends StatelessWidget {
  const FakeQrCode({super.key, required this.data, this.size = 120});

  final String data;
  final double size;

  static const int _n = 13;

  /// Pola "finder" 4x4 di tiga sudut: bingkai terisi, bagian dalam kosong.
  bool? _finderCell(int r, int c) {
    int? lr;
    int? lc;
    if (r < 4 && c < 4) {
      lr = r;
      lc = c;
    } else if (r < 4 && c >= _n - 4) {
      lr = r;
      lc = c - (_n - 4);
    } else if (r >= _n - 4 && c < 4) {
      lr = r - (_n - 4);
      lc = c;
    }
    if (lr == null || lc == null) return null; // bukan area finder
    return lr == 0 || lr == 3 || lc == 0 || lc == 3;
  }

  bool _filled(int r, int c) {
    final bool? finder = _finderCell(r, c);
    if (finder != null) return finder;
    final int seed = data.codeUnits.fold<int>(
      7,
      (a, b) => (a * 31 + b) & 0x7fffffff,
    );
    return ((seed >> ((r * _n + c) % 24)) + r * 3 + c * 5) % 3 != 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(Spacing.sm),
      color: Colors.white,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _n * _n,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _n,
        ),
        itemBuilder: (context, i) {
          final bool on = _filled(i ~/ _n, i % _n);
          return ColoredBox(color: on ? AppColors.ink : Colors.white);
        },
      ),
    );
  }
}
