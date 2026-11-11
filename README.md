# LifeGift

**Front-End Aplikasi Donor Darah & Organ Digital** — _"Connecting Hearts, Saving Lives Digitally"_

Prototipe antarmuka mobile berbasis **Flutter (Dart) + Material 3**, dibuat dari proposal proyek
*LifeGift* (SDGs Goal 3 & 17). Seluruh layar mengikuti desain UI pada slide 10–19 proposal.

## Anggota Kelompok

| Nama | NIM |
| --- | --- |
| Mhd Abimanyu Saraan | 241112201 |
| Nachelle | 241112498 |
| Vincent | 241112555 |
| Sean Ryo Valens Sahala | 241111106 |

## Fitur & Layar

Aplikasi memiliki 4 modul utama dan 10 layar (sesuai slide proposal):

| # | Layar | Modul | File |
| --- | --- | --- | --- |
| 01 | Splash & Selamat Datang | Onboarding | `lib/screens/splash_screen.dart` |
| 02 | Daftar & Skrining Awal | Onboarding | `lib/screens/register_screen.dart` |
| 03 | Home Dashboard | Beranda | `lib/screens/home_screen.dart` |
| 04 | Peta Donor Darurat | Donor Darah | `lib/screens/donor_map_screen.dart` |
| 05 | Detail & Respon Darurat | Donor Darah | `lib/screens/request_detail_screen.dart` |
| 06 | Registrasi Ikrar Donor Organ | Donor Organ | `lib/screens/organ_pledge_screen.dart` |
| 07 | Kartu Donor Digital (QR) | Donor Organ | `lib/screens/donor_card_screen.dart` |
| 08 | Pesan Tes Laboratorium | Cek Golongan Darah | `lib/screens/blood_test_screen.dart` |
| 09 | Konsultasi Medis Online | Konsultasi | `lib/screens/consult_screen.dart` |
| 10 | Profil, Riwayat & Badge | Profil | `lib/screens/profile_screen.dart` |

Kerangka navigasi 5 tab (Beranda · Donor · Organ · Konsul · Profil) ada di `lib/screens/app_shell.dart`.

Interaksi yang berfungsi pada prototipe ini: validasi form real-time, filter golongan darah & radius
pada peta, pilih organ & unggah dokumen (simulasi), pilih lab & jadwal, chat dengan balasan otomatis
(simulasi), ganti dokter, serta navigasi antarlayar.

## Pemetaan terhadap Ketentuan Tugas

| # | Ketentuan | Penerapan | Lokasi utama |
| --- | --- | --- | --- |
| 1 | **Flutter Fundamentals — Scaffold** | Setiap layar memakai `Scaffold` (`appBar`, `body`, `bottomNavigationBar`, `backgroundColor`). `AppShell` memakai `NavigationBar`/`NavigationRail`. | semua file di `lib/screens/` |
| 2 | **Vibe Coding Fundamentals** | Seluruh proses prompting didokumentasikan secara transparan, lengkap dengan catatan verifikasi & keterbatasan. | [`Prompts.md`](Prompts.md) |
| 3 | **Flutter UI Components** — Text, Icon, Image, RichText, CircleAvatar, Reusable Widget | `Text` & `Icon` di semua layar; `Image.asset` pada logo (`LifeGiftLogo`); `RichText` pada sapaan, detail permintaan, kartu donor, status dokter; `CircleAvatar` pada avatar, foto dokter, ikon; **reusable widget**: `InfoCard`, `BloodTypeBadge`, `StatTile`, `FeatureTile`, `RequestTile`, `PrimaryActionButton`, `SecondaryActionButton`, `SectionTitle`, `FieldLabel`, `FakeQrCode`, `LifeGiftLogo` | `lib/widgets/common_widgets.dart` |
| 4 | **Material Design & UI Dasar** — Material 3, warna, typography, spacing, hierarchy, components | `useMaterial3: true`, `ColorScheme.fromSeed`, design token warna (`AppColors`), spacing grid 4dp (`Spacing`), radius (`Radii`), `TextTheme` berjenjang (headline → title → body → label), komponen M3: `FilledButton`, `OutlinedButton`, `SegmentedButton`, `ChoiceChip`, `NavigationBar`, `NavigationRail`, `Slider`, `LinearProgressIndicator`, `AlertDialog`, `ModalBottomSheet`, `SnackBar`, `ExpansionTile` | `lib/theme/app_theme.dart` |
| 5 | **Flutter Layout Dasar** — Alignment, Container, Padding, SizedBox, Center | `Align`/`Alignment` untuk penanda peta & bubble chat; `Container` + `BoxDecoration`; `Padding`; `SizedBox` untuk jarak & ukuran tetap; `Center` pada header profil & splash | `donor_map_screen.dart`, `consult_screen.dart`, `profile_screen.dart`, dll. |
| 6 | **Flutter Multi-Child Layout** — Row, Column, ListView, GridView, Stack, Expanded, Carousel | `Row`/`Column`/`Expanded` di hampir semua layar; `ListView` (+`.builder`, `.separated`, horizontal) pada daftar & chat; `GridView` pada menu cepat, pilihan organ, dan `FakeQrCode`; `Stack` + `Positioned` pada kartu donor, peta, avatar profil; **`CarouselView`** pada banner permintaan darurat | `home_screen.dart` (Carousel, Grid, Stack), `donor_map_screen.dart` (Stack), `organ_pledge_screen.dart` (Grid) |
| 7 | **Responsive & Adaptive UI** — constraint, ukuran layar, orientasi, adaptasi layout | `LayoutBuilder` (constraint), `MediaQuery.sizeOf` (ukuran layar), `OrientationBuilder` (orientasi), `ConstrainedBox` (batas lebar), breakpoint Material 3 (`compact <600`, `medium <900`, `expanded ≥900`). Navigasi adaptif: `NavigationBar` ↔ `NavigationRail`. | `lib/theme/responsive.dart`, `app_shell.dart` |

### Rincian adaptasi layout (Ketentuan 7)

| Layar | Compact (ponsel portrait) | Medium / Expanded (landscape, tablet) |
| --- | --- | --- |
| App Shell | `NavigationBar` di bawah | `NavigationRail` di kiri (label disembunyikan jika tinggi < 480 dp) |
| Splash | Logo di atas, tombol di bawah (`Column`) | Logo kiri, tombol kanan (`Row`) |
| Registrasi | Golongan darah & Rhesus bertumpuk | Berdampingan (`LayoutBuilder` ≥ 480 dp) |
| Beranda | 1 kolom, menu 2 kolom | Medium: menu 4 kolom · Expanded: 2 panel (ringkasan \| menu) |
| Peta Donor | Peta di atas, daftar di bawah | Peta dan daftar berdampingan |
| Organ | Grid organ 2 kolom | 3 kolom → 6 kolom |
| Kartu Donor | Kartu di atas, aksi di bawah | Kartu dan aksi berdampingan |
| Profil | 1 kolom | 2 kolom (≥ 700 dp) |
| Konsultasi | Bubble maks. 75% lebar | Area chat dibatasi 720 dp dan dipusatkan |

## Struktur Proyek

```
lifegift/
├── assets/images/            # logo & avatar dokter (placeholder)
├── lib/
│   ├── main.dart             # entry point, MaterialApp (Material 3)
│   ├── theme/
│   │   ├── app_theme.dart    # warna, spacing, radius, typography, ThemeData
│   │   └── responsive.dart   # breakpoint & ResponsiveBody
│   ├── data/
│   │   ├── models.dart       # model data
│   │   └── dummy_data.dart   # data contoh sesuai slide
│   ├── widgets/
│   │   └── common_widgets.dart   # reusable widgets
│   └── screens/              # 10 layar + app shell
├── test/widget_test.dart
├── Prompts.md                # log vibe coding
└── pubspec.yaml
```

## Cara Menjalankan

Prasyarat: Flutter SDK **≥ 3.24** (untuk `CarouselView`) dan Dart ≥ 3.5.

Repositori ini berisi kode Dart (`lib/`), aset, dan `pubspec.yaml`. Folder platform
(`android/`, `ios/`, dll.) belum disertakan, sehingga generate dulu sekali:

```bash
cd lifegift
flutter create . --project-name lifegift --org id.ac.lifegift   # membuat folder platform, tidak menimpa lib/
flutter pub get
flutter run                      # pilih emulator / perangkat
flutter test                     # menjalankan widget test
```

Untuk mencoba tampilan responsif: jalankan di emulator tablet, putar perangkat ke landscape,
atau `flutter run -d chrome` lalu ubah ukuran jendela browser.

## Catatan Teknis

- **Tanpa paket eksternal** (hanya `flutter` SDK) agar mudah dijalankan dan murni memakai komponen
  bawaan sesuai ketentuan tugas. Beberapa item pada slide 8 (Riverpod, go_router, google_maps_flutter,
  Firebase FCM, dio, qr_flutter) adalah tahap integrasi berikutnya:
  - Peta pada layar 04 berupa **ilustrasi** dengan `Stack` (belum Google Maps).
  - QR pada kartu donor berupa **ilustrasi** `GridView` (belum QR valid yang dapat dipindai).
  - Chat, unggah dokumen, dan pemesanan lab adalah **simulasi** di sisi klien dengan data dummy.
- State dikelola sederhana dengan `StatefulWidget`/`setState`, navigasi dengan `Navigator`.
- Warna, font, dan tata letak mengikuti slide proposal. Font memakai default Material (Roboto).

## Transparansi Penggunaan AI

Proyek ini dikerjakan dengan pendekatan *vibe coding*. Log prompt, apa yang dihasilkan AI, serta
langkah verifikasi dan keterbatasannya ada di [`Prompts.md`](Prompts.md).
