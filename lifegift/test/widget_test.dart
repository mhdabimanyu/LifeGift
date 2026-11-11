import 'package:flutter_test/flutter_test.dart';

import 'package:lifegift/main.dart';

void main() {
  testWidgets('Splash LifeGift menampilkan tagline dan tombol utama', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LifeGiftApp());

    expect(find.text('LifeGift'), findsOneWidget);
    expect(find.text('Connecting Hearts, Saving Lives'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
    expect(find.text('Daftar Akun Baru'), findsOneWidget);
  });

  testWidgets('Tombol Masuk membuka AppShell dengan navigasi bawah', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LifeGiftApp());
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Beranda'), findsWidgets);
    expect(find.text('Menu Cepat'), findsOneWidget);
  });
}
