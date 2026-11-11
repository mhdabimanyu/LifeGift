# Prompts.md — Log Vibe Coding LifeGift

Dokumen ini mencatat penggunaan AI (vibe coding) dalam proyek **LifeGift** secara transparan:
apa yang diminta, apa yang dihasilkan, dan bagaimana hasilnya diperiksa.

- **Alat AI:** Claude (Anthropic) pada antarmuka chat.
- **Input yang diberikan ke AI:** file proposal `241112201_Abimanyu_ProposalProyekFlutter_R1.pptx`
  (21 slide; fitur pada slide 5–7, UI layar pada slide 10–19).
- **Tim:** Mhd Abimanyu Saraan (241112201), Nachelle (241112498), Vincent (241112555),
  Sean Ryo Valens Sahala (241111106).

## Ringkasan Alur Vibe Coding

1. **Konteks dulu**: AI membaca seluruh isi PPT (teks semua slide + tampilan visual slide 10–19)
   untuk mengambil fitur, alur pengguna, warna, dan susunan layar.
2. **Spesifikasi eksplisit**: 7 ketentuan tugas dijadikan *acceptance criteria* dalam prompt.
3. **Bangun bertahap**: tema & design token → data dummy → widget reusable → layar → navigasi → test.
4. **Verifikasi**: sintaks seluruh file Dart diperiksa dengan `dart format`; sisanya wajib dicek tim
   dengan `flutter analyze` dan `flutter run` (lihat bagian Keterbatasan).

---

## Log Prompt

### Prompt #1 — Prompt awal (dijalankan; teks asli dari tim)

> Buatlah halaman aplikasi menggunakan flutter dart untuk Fitur fitur nya dapat kamu baca di dalam ppt nya
> untuk UI nya ada di slide 10 dan 19
> adapun ketentuan yang dipenuhi:
> 1. Flutter Fundamentals — dengan penerapan Scaffold
> 2. Vibe Coding Fundamentals — Vibe Coding dengan jelas
> 3. Flutter UI Components — Text, Icon, Image, RichText, CircleAvatar, Reusable Widget
> 4. Material Design & UI Dasar — Material 3, warna, typography, spacing, hierarchy, components
> 5. Flutter Layout Dasar — Alignment, Container, Padding, SizedBox, Center
> 6. Flutter Multi-Child Layout — Row, Column, ListView, GridView, Stack, Expanded, Carousel
> 7. Responsive & Adaptive UI — Constraint, ukuran layar, orientasi, dan adaptasi layout
>
> buatkan readme yang dimana [daftar anggota]
> buat file Prompts.md untuk memuat log prompting/vibe coding secara transparan
> untuk prompt nya dapat kamu sesuai kan saja

**Hasil dari AI:**
- Membaca PPT; mengidentifikasi 4 modul, 10 layar (slide 10–19), palet warna
  (`#881337`, `#E11D48`, `#0F172A`, `#475569`, dll.).
- Membuat proyek Flutter lengkap: `pubspec.yaml`, `lib/` (tema, data, widget reusable, 10 layar,
  app shell), aset gambar (logo & avatar dokter placeholder), `test/widget_test.dart`,
  `README.md`, dan `Prompts.md` ini.
- Keputusan desain yang dibuat AI (dapat ditinjau tim):
  - Tanpa paket eksternal; peta dan QR berupa ilustrasi, bukan integrasi nyata.
  - `NavigationBar` ↔ `NavigationRail` sebagai navigasi adaptif.
  - Breakpoint 600/900 dp mengikuti Material 3.
  - Menggunakan `CarouselView` (butuh Flutter ≥ 3.24).

**Pemeriksaan yang dilakukan:** sintaks seluruh file Dart lolos `dart format` (Dart 3.13).
Kode **belum dikompilasi dan dijalankan** karena Flutter SDK tidak tersedia di lingkungan AI.

---

### Prompt lanjutan — Siap pakai (BELUM dijalankan)

Prompt di bawah ini disiapkan untuk iterasi berikutnya. Kolom **Status** harus diperbarui tim setelah
benar-benar dijalankan agar log tetap jujur.

| # | Tujuan | Prompt yang disarankan | Status |
| --- | --- | --- | --- |
| 2 | Perbaiki error kompilasi | "Berikut output `flutter analyze` / error `flutter run` dari proyek LifeGift: `[tempel error]`. Perbaiki hanya file yang bermasalah dan jelaskan penyebabnya." | ⬜ belum |
| 3 | Review UI vs slide | "Ini screenshot layar `[nama layar]` dari emulator dan slide `[nomor]` dari proposal. Sebutkan perbedaan spacing, warna, dan tipografi, lalu perbaiki." | ⬜ belum |
| 4 | Uji responsif | "Aplikasi overflow pada `[perangkat/ukuran/orientasi]` di layar `[nama]` (screenshot terlampir). Perbaiki dengan LayoutBuilder/Expanded tanpa mengubah layar lain." | ⬜ belum |
| 5 | Peta nyata | "Ganti ilustrasi peta pada `donor_map_screen.dart` dengan `google_maps_flutter` dan `geolocator`. Pertahankan filter dan daftar permintaan." | ⬜ belum |
| 6 | QR valid | "Ganti `FakeQrCode` dengan `qr_flutter` yang meng-encode nomor registrasi, tanpa mengubah API widget." | ⬜ belum |
| 7 | State management | "Pindahkan state filter donor dan chat ke Riverpod sesuai slide 8, jelaskan struktur provider." | ⬜ belum |
| 8 | Test | "Tambahkan widget test untuk validasi form registrasi dan filter peta donor." | ⬜ belum |

---

## Template Pencatatan (salin untuk setiap prompt baru)

```
### Prompt #N — <judul singkat>
- Tanggal / anggota yang menjalankan:
- Alat AI & model:
- Prompt (teks asli):
- Ringkasan hasil AI:
- File yang berubah:
- Verifikasi yang dilakukan (analyze / run / test / screenshot):
- Yang diubah manual oleh tim (dan alasannya):
- Masalah / halusinasi yang ditemukan:
```

## Prinsip Vibe Coding yang Dipakai Tim

1. **Beri konteks yang konkret** (slide proposal, daftar fitur, ketentuan tugas) — bukan permintaan umum.
2. **Jadikan ketentuan tugas sebagai checklist** dan minta AI memetakannya ke file/baris (lihat README).
3. **Minta kode kecil dan bertahap**, bukan satu prompt besar yang sulit di-debug.
4. **Jangan percaya begitu saja**: setiap hasil AI dijalankan, dibaca, dan dipahami sebelum dikumpulkan.
5. **Catat semua prompt** beserta hasil dan koreksi manual di dokumen ini.

## Keterbatasan & Hal yang Harus Diverifikasi Tim

- Kode **belum pernah dijalankan di Flutter SDK**; hanya sintaks Dart yang diperiksa. Jalankan
  `flutter pub get`, `flutter analyze`, `flutter test`, lalu `flutter run`. Bisa muncul peringatan lint
  atau perbedaan API tergantung versi Flutter.
- Folder platform (`android/`, `ios/`) belum ada: jalankan `flutter create .` (lihat README).
- Layar belum diuji visual di perangkat nyata; periksa overflow pada ukuran layar kecil dan landscape.
- Data bersifat dummy; peta, QR, chat, unggah dokumen, dan pemesanan lab masih simulasi.
- Aset gambar adalah placeholder yang dibuat otomatis; ganti dengan aset resmi bila ada.
- Anggota tim sebaiknya memahami kode sebelum dikumpulkan dan memperbarui log ini dengan prompt
  nyata yang dijalankan selanjutnya.
