# Prompts.md — Log Vibe Coding LifeGift

Dokumen ini mencatat penggunaan AI (*vibe coding*) dalam proyek **LifeGift** secara transparan: apa yang diminta, masalah yang ditemukan, arahan perbaikan, dan bagaimana hasilnya diperiksa.

- **Alat AI:** Claude (Anthropic), sesuai catatan tim.
- **Input utama:** file proposal `241112201_Abimanyu_ProposalProyekFlutter_R1.pptx` (21 slide).
- **Referensi fitur dan UI:** fitur pada slide 5–7 dan rancangan layar pada slide 10–19.
- **Tim:**
  - Mhd Abimanyu Saraan (241112201)
  - Nachelle (241112498)
  - Vincent (241112555)
  - Sean Ryo Valens Sahala (241111106)

> Catatan transparansi: Prompt #1 merupakan prompt awal proyek. Prompt #2–#5 di bawah disusun berdasarkan masalah UI yang terlihat pada screenshot dan kebutuhan debugging. Status verifikasi harus diperbarui oleh tim setelah perubahan benar-benar dijalankan dan diuji.

---

## Ringkasan Alur Vibe Coding

1. **Konteks:** AI diberi proposal PPT agar fitur, alur pengguna, dan rancangan UI LifeGift menjadi acuan.
2. **Spesifikasi:** tujuh ketentuan tugas Flutter dijadikan kriteria pemeriksaan.
3. **Pembuatan bertahap:** tema, data contoh, widget reusable, layar aplikasi, navigasi, dan test dibuat secara bertahap.
4. **Debugging:** ketika muncul masalah UI atau kompilasi, tim memberikan pesan error atau screenshot kepada AI, lalu meminta perbaikan yang terfokus.
5. **Verifikasi:** hasil perbaikan perlu diperiksa dengan `flutter analyze`, `flutter run`, widget test, dan screenshot pada ukuran layar yang berbeda.

---

## Log Prompt

### Prompt #1 — Prompt awal proyek (dijalankan)

**Prompt:**

> Buatlah halaman aplikasi menggunakan Flutter Dart. Fitur-fiturnya dapat dibaca di dalam PPT, sedangkan referensi UI terdapat pada slide 10 dan 19.
>
> Ketentuan yang harus dipenuhi:
> 1. Flutter Fundamentals — penerapan Scaffold.
> 2. Vibe Coding Fundamentals — proses vibe coding dicatat dengan jelas.
> 3. Flutter UI Components — Text, Icon, Image, RichText, CircleAvatar, dan Reusable Widget.
> 4. Material Design & UI Dasar — Material 3, warna, typography, spacing, hierarchy, dan components.
> 5. Flutter Layout Dasar — Alignment, Container, Padding, SizedBox, dan Center.
> 6. Flutter Multi-Child Layout — Row, Column, ListView, GridView, Stack, Expanded, dan Carousel.
> 7. Responsive & Adaptive UI — Constraint, ukuran layar, orientasi, dan adaptasi layout.
>
> Buat README yang mencantumkan nama dan NIM anggota kelompok. Buat juga file Prompts.md untuk mencatat log prompting/vibe coding secara transparan.

**Ringkasan hasil:**

- AI membantu menyusun struktur awal proyek Flutter dan halaman-halaman utama LifeGift.
- Komponen UI dibuat dengan widget Flutter dan Material Design.
- README dan Prompts.md disiapkan sebagai dokumentasi proyek.

**Pemeriksaan:** tim perlu menjalankan aplikasi pada Flutter SDK lokal dan memastikan implementasi sesuai dengan proposal.

**Status:** Prompt awal digunakan sebagai dasar pembuatan proyek.

---

### Prompt #2 — Investigasi masalah overflow pada daftar badge (berdasarkan screenshot)

**File terkait:** `lib/profile_screen.dart`  
**Widget terkait:** `_BadgeList`

**Masalah yang ditemukan:**

Pada bagian daftar badge di halaman profil, muncul pesan UI:

```text
BOTTOM OVERFLOWED BY 6.0 PIXELS
```

Pesan tersebut terlihat pada kartu badge seperti “Pahlawan Pe…”, “Donor Rutin”, dan “Penyelamat”. Konten bagian bawah kartu terlihat terpotong/berdesakan.

**Prompt:**

> Saya menemukan masalah layout pada `profile_screen.dart`, tepatnya di widget `_BadgeList`. Saat aplikasi dijalankan, beberapa kartu badge menampilkan pesan `BOTTOM OVERFLOWED BY 6.0 PIXELS`, seperti yang terlihat pada screenshot.
>
> Tolong periksa susunan widget di dalam `_BadgeList`, terutama penggunaan `Container`, `Column`, `Padding`, `SizedBox`, dan tinggi kartu. Cari penyebab konten melebihi ruang vertikal yang tersedia. Jelaskan penyebabnya terlebih dahulu, lalu berikan perbaikan yang hanya menyentuh bagian daftar badge. Jangan mengubah bagian riwayat donor atau halaman lain.

**Ringkasan hasil/arah perbaikan:**

- Fokus pemeriksaan diarahkan ke tinggi kartu badge dan total tinggi konten di dalamnya.
- Perlu diperiksa apakah kombinasi ikon, judul badge, teks keterangan, padding, dan jarak vertikal melebihi tinggi kartu.
- Perbaikan harus menjaga seluruh konten badge tetap terlihat tanpa mengubah desain halaman profil secara keseluruhan.

**File yang diperiksa:** `lib/profile_screen.dart`.

**Status:** Masalah teridentifikasi melalui screenshot; hasil perbaikan perlu diverifikasi kembali setelah kode diperbarui.

---

### Prompt #3 — Memperbaiki tinggi dan susunan konten kartu badge

**File terkait:** `lib/profile_screen.dart`  
**Widget terkait:** `_BadgeList`

**Prompt:**

> Lanjutkan perbaikan pada widget `_BadgeList` di `profile_screen.dart`. Hilangkan `BOTTOM OVERFLOWED BY 6.0 PIXELS` pada setiap kartu badge.
>
> Sesuaikan tinggi minimum kartu, padding, dan jarak antar-widget agar ikon, nama badge, serta keterangan dapat ditampilkan dengan utuh. Hindari menetapkan tinggi yang terlalu kecil. Gunakan pendekatan layout Flutter yang sesuai, misalnya `mainAxisSize: MainAxisSize.min`, `Flexible`, atau penyesuaian constraint apabila memang diperlukan oleh struktur kode.
>
> Pertahankan warna, bentuk kartu, ukuran ikon, dan gaya visual yang sudah ada sebisa mungkin. Tampilkan bagian kode sebelum dan sesudah perbaikan serta jelaskan alasan perubahan.

**Ringkasan hasil yang diharapkan:**

- Kartu badge memiliki ruang vertikal yang cukup.
- Judul dan keterangan badge tidak terpotong.
- Indikator overflow tidak muncul lagi.
- Tampilan badge tetap konsisten dengan desain halaman profil.

**Verifikasi yang perlu dilakukan:** jalankan ulang aplikasi dan periksa apakah pesan overflow sudah hilang pada seluruh kartu badge.

**Status:** Perlu dikonfirmasi setelah pengujian ulang.

---

### Prompt #4 — Memeriksa responsivitas daftar badge

**File terkait:** `lib/profile_screen.dart`  
**Widget terkait:** `_BadgeList`

**Prompt:**

> Setelah masalah overflow pada `_BadgeList` diperbaiki, periksa tampilan daftar badge pada lebar layar yang berbeda, seperti layar HP yang sempit dan layar yang lebih lebar.
>
> Pastikan kartu badge tidak saling bertumpuk, teks tidak terpotong secara tidak sengaja, dan tinggi kartu cukup untuk menampilkan seluruh konten. Gunakan constraint atau layout responsif bila diperlukan. Jangan mengubah susunan bagian riwayat donor.
>
> Jelaskan perubahan yang dilakukan dan sebutkan ukuran layar yang perlu digunakan untuk pengujian.

**Ringkasan hasil yang diharapkan:**

- Kartu badge tetap rapi pada ukuran layar yang berbeda.
- Tidak muncul overflow horizontal maupun vertikal.
- Jarak antar-kartu tetap konsisten.

**Verifikasi yang perlu dilakukan:** ambil screenshot pada setidaknya satu ukuran layar HP dan satu ukuran layar yang lebih lebar.

**Status:** Perlu diuji oleh tim.

---

### Prompt #5 — Verifikasi akhir halaman profil

**File terkait:** `lib/profile_screen.dart`

**Prompt:**

> Lakukan pemeriksaan akhir pada halaman profil LifeGift setelah perbaikan `_BadgeList`. Pastikan bagian informasi pengguna, daftar badge, statistik, riwayat donor, dan pengingat donor tetap tampil dengan benar.
>
> Periksa apakah masih ada pesan overflow atau error layout. Jangan mengubah bagian yang sudah berjalan baik. Berikan daftar pemeriksaan yang dapat dilakukan tim melalui `flutter analyze` dan `flutter run`.

**Ringkasan hasil yang diharapkan:**

- Tidak ada error layout pada halaman profil.
- Seluruh kartu badge dan riwayat donor terlihat.
- Tampilan tetap konsisten dengan rancangan UI proposal.

**Verifikasi yang perlu dilakukan:** jalankan `flutter analyze`, `flutter run`, dan pemeriksaan visual melalui screenshot.

**Status:** Perlu diuji oleh tim.

---

## Prompt lanjutan — Siap digunakan (belum dijalankan)

Prompt berikut merupakan rencana iterasi berikutnya. Ubah status setelah prompt benar-benar dijalankan.

| # | Tujuan | Prompt |
|---|---|---|
| 6 | Review UI terhadap slide | “Bandingkan screenshot layar `[nama layar]` dengan slide `[nomor]` pada proposal. Identifikasi perbedaan spacing, warna, tipografi, dan susunan komponen, lalu sarankan perbaikannya.” |
| 7 | Perbaikan error kompilasi | “Berikut output `flutter analyze` atau `flutter run`: `[tempel error]`. Jelaskan penyebabnya dan perbaiki hanya file yang bermasalah.” |
| 8 | Pengujian responsif | “Periksa screenshot aplikasi pada ukuran `[ukuran layar]` dan orientasi `[portrait/landscape]`. Temukan overflow atau layout yang tidak sesuai dan perbaiki tanpa mengubah layar lain.” |
| 9 | Peta donor | “Ganti ilustrasi peta pada halaman donor dengan integrasi peta sesuai kebutuhan proyek. Jelaskan konfigurasi dan dependency yang diperlukan sebelum mengubah kode.” |
| 10 | QR Code | “Ganti tampilan QR placeholder dengan QR Code yang dapat dibuat dari nomor registrasi donor. Pertahankan desain kartu donor digital.” |
| 11 | State management | “Tinjau kebutuhan state pada filter donor dan chat. Sarankan struktur state management yang sesuai dengan skala proyek sebelum melakukan refactor.” |
| 12 | Widget test | “Tambahkan widget test untuk memeriksa tampilan profil, daftar badge, dan validasi form registrasi. Pastikan test menggunakan nama widget dan import yang sesuai dengan proyek.” |

---

## Template Pencatatan (untuk setiap prompt baru)

Salin template ini setiap kali tim melakukan iterasi baru.

```text
### Prompt #N — <judul singkat>
- Tanggal / anggota yang menjalankan:
- Alat AI & model:
- Prompt (teks asli):
- Error atau kebutuhan yang ditemukan:
- Ringkasan hasil AI:
- File yang berubah:
- Verifikasi yang dilakukan (analyze / run / test / screenshot):
- Yang diubah manual oleh tim (dan alasannya):
- Masalah / halusinasi yang ditemukan:
- Status: berhasil / perlu revisi / belum diuji
```

## Prinsip Vibe Coding yang Dipakai Tim

1. **Berikan konteks konkret:** gunakan proposal, daftar fitur, screenshot, dan ketentuan tugas sebagai acuan.
2. **Jadikan ketentuan tugas sebagai checklist:** petakan setiap kebutuhan ke komponen atau file proyek.
3. **Kerjakan secara bertahap:** pisahkan pembuatan UI, navigasi, responsive layout, dan debugging.
4. **Periksa hasil AI:** jalankan kode dan pahami perubahan sebelum digunakan.
5. **Catat proses secara jujur:** bedakan prompt yang sudah dijalankan, perbaikan yang sudah diuji, dan prompt yang masih berupa rencana.
