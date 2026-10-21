import 'package:flutter/material.dart';

void main() => runApp(const LifeGiftApp());

const brand = Color(0xFFE34B5F);
const ink = Color(0xFF243044);
const pale = Color(0xFFFFF2F3);
const green = Color(0xFF16856B);

class LifeGiftApp extends StatelessWidget {
  const LifeGiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeGift',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brand),
        scaffoldBackgroundColor: const Color(0xFFF8F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, foregroundColor: ink, elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E7EE))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E7EE))),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outlined;
  const AppButton({super.key, required this.label, required this.onPressed, this.icon, this.outlined = false});

  @override
  Widget build(BuildContext context) {
    final child = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (icon != null) ...[Icon(icon, size: 19), const SizedBox(width: 8)],
      Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    ]);
    if (outlined) {
      return OutlinedButton(onPressed: onPressed, style: OutlinedButton.styleFrom(
        foregroundColor: brand, side: const BorderSide(color: brand),
        padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: child);
    }
    return FilledButton(onPressed: onPressed, style: FilledButton.styleFrom(
      backgroundColor: brand, foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: child);
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Padding(padding: const EdgeInsets.all(26), child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Spacer(),
        Container(width: 112, height: 112, decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(32)),
          child: const Icon(Icons.volunteer_activism_rounded, color: brand, size: 66)),
        const SizedBox(height: 24),
        const Text('LifeGift', textAlign: TextAlign.center, style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: ink)),
        const SizedBox(height: 10),
        const Text('Satu kepedulian, banyak kehidupan.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54)),
        const SizedBox(height: 18),
        const Text('Hubungkan kebaikan dengan orang yang membutuhkan melalui donor darah, ikrar donor organ, dan layanan kesehatan.',
          textAlign: TextAlign.center, style: TextStyle(height: 1.5, color: Colors.black54)),
        const Spacer(),
        AppButton(label: 'Masuk', icon: Icons.login, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
        const SizedBox(height: 12),
        AppButton(label: 'Daftar akun baru', icon: Icons.person_add_alt_1, outlined: true,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()))),
        const SizedBox(height: 16),
        const Text('Konsep front-end edukatif • Bukan layanan medis resmi', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.black45)),
      ]))),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(); final password = TextEditingController();
  @override void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Masuk ke LifeGift')),
    body: ListView(padding: const EdgeInsets.all(22), children: [
      const Icon(Icons.lock_open_rounded, size: 54, color: brand),
      const SizedBox(height: 18),
      const Text('Selamat datang kembali!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ink)),
      const SizedBox(height: 8), const Text('Masuk untuk melihat aktivitas dan kontribusi kemanusiaan Anda.'),
      const SizedBox(height: 24),
      TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined))),
      const SizedBox(height: 14),
      TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Kata sandi', prefixIcon: Icon(Icons.lock_outline))),
      const SizedBox(height: 20),
      AppButton(label: 'Masuk', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeShell()))),
      const SizedBox(height: 10),
      const Text('Demo UI: autentikasi belum terhubung ke server.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontSize: 12)),
    ]),
  );
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  String blood = 'O'; String rhesus = 'Positif'; bool agree = false;
  final name = TextEditingController(); final email = TextEditingController();
  @override void dispose() { name.dispose(); email.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registrasi & skrining awal')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Buat akun LifeGift', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ink)),
      const SizedBox(height: 8), const Text('Isi data awal. Informasi medis harus ditinjau oleh tenaga kesehatan.'),
      const SizedBox(height: 20),
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Nama lengkap', prefixIcon: Icon(Icons.person_outline))),
      const SizedBox(height: 12),
      TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email aktif', prefixIcon: Icon(Icons.email_outlined))),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: blood, decoration: const InputDecoration(labelText: 'Golongan darah'), items: ['A','B','AB','O','Belum tahu'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => blood = v!)),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: rhesus, decoration: const InputDecoration(labelText: 'Rhesus'), items: ['Positif','Negatif','Belum tahu'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => rhesus = v!)),
      const SizedBox(height: 12),
      const TextField(maxLines: 3, decoration: InputDecoration(labelText: 'Riwayat kesehatan singkat (opsional)', alignLabelWithHint: true)),
      const SizedBox(height: 12),
      CheckboxListTile(value: agree, onChanged: (v) => setState(() => agree = v ?? false), contentPadding: EdgeInsets.zero,
        title: const Text('Saya menyetujui penggunaan data untuk simulasi aplikasi ini.', style: TextStyle(fontSize: 13))),
      AppButton(label: 'Daftar', onPressed: () {
        if (name.text.trim().isEmpty || email.text.trim().isEmpty || !agree) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Isi nama, email, dan centang persetujuan terlebih dahulu.'))); return;
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registrasi demo berhasil. Silakan masuk.')));
        Navigator.pop(context);
      }),
    ]),
  );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override State<HomeShell> createState() => _HomeShellState();
}
class _HomeShellState extends State<HomeShell> {
  int index = 0;
  final pages = const [DashboardScreen(), BloodScreen(), OrganScreen(), LabScreen(), ProfileScreen()];
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Row(children: [const Icon(Icons.volunteer_activism, color: brand), const SizedBox(width: 8), const Text('LifeGift', style: TextStyle(fontWeight: FontWeight.w900))]),
      actions: [IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Belum ada notifikasi baru.'))), icon: const Icon(Icons.notifications_none))]),
    body: pages[index],
    bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
        NavigationDestination(icon: Icon(Icons.bloodtype_outlined), selectedIcon: Icon(Icons.bloodtype), label: 'Donor'),
        NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Organ'),
        NavigationDestination(icon: Icon(Icons.biotech_outlined), selectedIcon: Icon(Icons.biotech), label: 'Tes darah'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
      ]),
  );
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Halo, Sahabat LifeGift 👋', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: ink)),
    const SizedBox(height: 5), const Text('Setiap aksi kecil dapat menyelamatkan kehidupan.'),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: brand, borderRadius: BorderRadius.circular(22)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.favorite, color: Colors.white, size: 30),
        SizedBox(height: 12), Text('Satu donor dapat memberi harapan.', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 6), Text('Lihat kebutuhan donor dan temukan cara untuk membantu.', style: TextStyle(color: Colors.white70)),
      ])),
    const SizedBox(height: 18),
    const Row(children: [Expanded(child: StatCard(icon: Icons.water_drop, value: '0', label: 'Donor darah')), SizedBox(width: 12), Expanded(child: StatCard(icon: Icons.volunteer_activism, value: '1', label: 'Aksi kebaikan'))]),
    const SizedBox(height: 22), const SectionTitle('Akses cepat'),
    GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4,
      children: [
        QuickCard(icon: Icons.bloodtype, title: 'Donor darah', subtitle: 'Cari permintaan', onTap: () => _go(context, 1)),
        QuickCard(icon: Icons.favorite, title: 'Donor organ', subtitle: 'Daftar ikrar', onTap: () => _go(context, 2)),
        QuickCard(icon: Icons.biotech, title: 'Cek golongan', subtitle: 'Cari laboratorium', onTap: () => _go(context, 3)),
        QuickCard(icon: Icons.chat_bubble_outline, title: 'Konsultasi', subtitle: 'Tanya tim medis', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConsultationScreen()))),
      ]),
    const SizedBox(height: 20), const SectionTitle('Permintaan darurat terdekat'),
    const RequestCard(),
  ]);
  void _go(BuildContext context, int tab) {
    final state = context.findAncestorStateOfType<_HomeShellState>();
    state?.setState(() => state.index = tab);
  }
}

class StatCard extends StatelessWidget {
  final IconData icon; final String value; final String label;
  const StatCard({super.key, required this.icon, required this.value, required this.label});
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: brand), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12))]));
}
class SectionTitle extends StatelessWidget {
  final String text; const SectionTitle(this.text, {super.key});
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ink)));
}
class QuickCard extends StatelessWidget {
  final IconData icon; final String title; final String subtitle; final VoidCallback onTap;
  const QuickCard({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFEEF0F5))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: brand, size: 28), const SizedBox(height: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12))])));
}
class RequestCard extends StatelessWidget {
  const RequestCard({super.key});
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.bloodtype, color: brand, size: 30)),
        const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Kebutuhan darah O+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('RS Harapan • 3,2 km (data demo)', style: TextStyle(color: Colors.black54, fontSize: 12))])),
        const Text('DARURAT', style: TextStyle(color: brand, fontWeight: FontWeight.bold, fontSize: 10))]),
      const SizedBox(height: 14), const Text('Dibutuhkan 2 kantong sebelum pukul 21.00. Hubungi fasilitas kesehatan untuk konfirmasi resmi.'),
      const SizedBox(height: 12), AppButton(label: 'Lihat detail & respon', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BloodDetailScreen()))),
    ]));
}

class BloodScreen extends StatefulWidget {
  const BloodScreen({super.key});
  @override State<BloodScreen> createState() => _BloodScreenState();
}
class _BloodScreenState extends State<BloodScreen> {
  String blood = 'Semua'; double distance = 10;
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Donor darah darurat', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ink)),
    const SizedBox(height: 6), const Text('Pilih permintaan yang sesuai. Lokasi dan permintaan di bawah adalah data simulasi.'),
    const SizedBox(height: 18),
    Container(height: 155, decoration: BoxDecoration(color: const Color(0xFFE4F2EE), borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        const Center(child: Icon(Icons.map_outlined, size: 75, color: green)),
        Positioned(left: 20, top: 22, child: _mapPin('RS Harapan')),
        Positioned(right: 18, bottom: 25, child: _mapPin('PMI Kota')),
        const Positioned(left: 18, bottom: 12, child: Text('Peta ilustrasi • GPS belum terhubung', style: TextStyle(fontSize: 10, color: Colors.black54))),
      ])),
    const SizedBox(height: 18), const SectionTitle('Filter pencarian'),
    DropdownButtonFormField<String>(value: blood, decoration: const InputDecoration(labelText: 'Golongan darah'), items: ['Semua','A','B','AB','O'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => blood = v!)),
    const SizedBox(height: 8), Text('Jarak maksimal: ${distance.round()} km'),
    Slider(value: distance, min: 1, max: 30, divisions: 29, activeColor: brand, onChanged: (v) => setState(() => distance = v)),
    const SizedBox(height: 8), const SectionTitle('Permintaan terdekat'),
    RequestCard(),
    const SizedBox(height: 12), RequestTile(group: 'A+', place: 'PMI Kota Medan', distance: '5,1 km'),
    RequestTile(group: 'B+', place: 'RS Sehat Bersama', distance: '7,4 km'),
  ]);
  Widget _mapPin(String name) => Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Row(children: [const Icon(Icons.location_on, color: brand, size: 16), Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]));
}
class RequestTile extends StatelessWidget {
  final String group, place, distance;
  const RequestTile({super.key, required this.group, required this.place, required this.distance});
  @override Widget build(BuildContext context) => Card(color: Colors.white, child: ListTile(leading: CircleAvatar(backgroundColor: pale, child: Text(group, style: const TextStyle(color: brand, fontWeight: FontWeight.bold))),
    title: Text(place), subtitle: Text('$distance • Data simulasi'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BloodDetailScreen()))));
}
class BloodDetailScreen extends StatelessWidget {
  const BloodDetailScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Detail permintaan donor')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const RequestCard(),
      const SizedBox(height: 18), const SectionTitle('Informasi kebutuhan'),
      const InfoRow(icon: Icons.bloodtype, title: 'Golongan darah', value: 'O rhesus positif'),
      const InfoRow(icon: Icons.local_hospital, title: 'Fasilitas', value: 'RS Harapan (data demo)'),
      const InfoRow(icon: Icons.timer_outlined, title: 'Batas waktu', value: 'Hari ini, pukul 21.00'),
      const InfoRow(icon: Icons.health_and_safety_outlined, title: 'Kelayakan', value: 'Harus dikonfirmasi petugas medis'),
      const SizedBox(height: 16),
      AppButton(label: 'Saya bersedia membantu', icon: Icons.volunteer_activism, onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Terima kasih!'), content: const Text('Ini hanya simulasi. Hubungi PMI/rumah sakit untuk konfirmasi dan skrining resmi.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Mengerti'))]))),
      const SizedBox(height: 10), AppButton(label: 'Lihat rute (demo)', icon: Icons.directions, outlined: true, onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Integrasi peta belum tersedia.')))),
    ]));
}
class InfoRow extends StatelessWidget {
  final IconData icon; final String title, value;
  const InfoRow({super.key, required this.icon, required this.title, required this.value});
  @override Widget build(BuildContext context) => ListTile(contentPadding: EdgeInsets.zero, leading: Icon(icon, color: brand), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(value));
}

class OrganScreen extends StatefulWidget {
  const OrganScreen({super.key});
  @override State<OrganScreen> createState() => _OrganScreenState();
}
class _OrganScreenState extends State<OrganScreen> {
  final organs = <String>{'Ginjal'}; bool family = false; bool legal = false;
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Ikrar donor organ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ink)),
    const SizedBox(height: 8), const Text('Pendaftaran ini hanya prototipe. Prosedur donor organ wajib mengikuti ketentuan hukum dan fasilitas resmi.'),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(18)), child: const Row(children: [Icon(Icons.favorite, color: brand, size: 38), SizedBox(width: 12), Expanded(child: Text('Niat baik perlu informasi yang benar dan persetujuan yang jelas.', style: TextStyle(fontWeight: FontWeight.w600)))])),
    const SizedBox(height: 20), const SectionTitle('1. Pilih organ (simulasi)'),
    ...['Ginjal','Hati','Kornea mata','Jaringan lain'].map((o) => CheckboxListTile(value: organs.contains(o), title: Text(o), activeColor: brand, onChanged: (v) => setState(() { if (v == true) { organs.add(o); } else { organs.remove(o); } }))),
    const SizedBox(height: 12), const SectionTitle('2. Dokumen & persetujuan'),
    const ListTile(leading: Icon(Icons.upload_file, color: brand), title: Text('Identitas diri'), subtitle: Text('Unggah dokumen: belum tersedia pada demo'), trailing: Icon(Icons.attach_file)),
    CheckboxListTile(value: family, onChanged: (v) => setState(() => family = v ?? false), title: const Text('Saya telah membicarakan niat ini dengan keluarga.'), activeColor: brand),
    CheckboxListTile(value: legal, onChanged: (v) => setState(() => legal = v ?? false), title: const Text('Saya memahami bahwa verifikasi resmi diperlukan.'), activeColor: brand),
    const SizedBox(height: 8), AppButton(label: 'Kirim untuk simulasi verifikasi', onPressed: () {
      if (organs.isEmpty || !family || !legal) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih organ dan lengkapi kedua persetujuan.'))); return; }
      Navigator.push(context, MaterialPageRoute(builder: (_) => OrganCardScreen(organs: organs.toList())));
    }),
    const SizedBox(height: 12), AppButton(label: 'Lihat kartu donor digital demo', outlined: true, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrganCardScreen(organs: organs.toList())))),
  ]);
}

class OrganCardScreen extends StatelessWidget {
  final List<String> organs;
  const OrganCardScreen({super.key, required this.organs});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Kartu donor digital')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: const LinearGradient(colors: [brand, Color(0xFFB82D49)]), borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [Icon(Icons.volunteer_activism, color: Colors.white, size: 28), SizedBox(width: 8), Text('LifeGift', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22))]),
          const SizedBox(height: 26), const Text('KARTU IKRAH DONOR', style: TextStyle(color: Colors.white70, letterSpacing: 1.2, fontSize: 12)),
          const SizedBox(height: 8), const Text('Sahabat LifeGift', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8), Text('Pilihan organ: ${organs.isEmpty ? 'Belum dipilih' : organs.join(', ')}', style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 20), const Row(children: [Icon(Icons.qr_code_2, size: 70, color: Colors.white), SizedBox(width: 14), Expanded(child: Text('QR ilustrasi\\nStatus: Menunggu verifikasi\\nBukan dokumen resmi', style: TextStyle(color: Colors.white, height: 1.5)))]),
        ])),
      const SizedBox(height: 18), const Text('Kartu ini hanya visualisasi antarmuka. QR, identitas, dan verifikasi belum terhubung ke sistem resmi.'),
      const SizedBox(height: 16), AppButton(label: 'Bagikan kartu (demo)', icon: Icons.share, onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur berbagi belum diintegrasikan.')))),
    ]));
}

class LabScreen extends StatefulWidget {
  const LabScreen({super.key});
  @override State<LabScreen> createState() => _LabScreenState();
}
class _LabScreenState extends State<LabScreen> {
  String selected = '09.00'; String lab = 'Lab Medika';
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Cek golongan darah', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ink)),
    const SizedBox(height: 8), const Text('Bandingkan pilihan laboratorium dan pilih jadwal tes (data simulasi).'),
    const SizedBox(height: 18),
    const SectionTitle('Laboratorium terdekat'),
    _labTile('Lab Medika', 'Rp75.000', '1,8 km', Icons.biotech),
    _labTile('Klinik Sehat', 'Rp90.000', '3,5 km', Icons.local_hospital),
    _labTile('Lab Sentosa', 'Rp65.000', '5,2 km', Icons.science_outlined),
    const SizedBox(height: 16), const SectionTitle('Pilih jadwal'),
    DropdownButtonFormField<String>(value: lab, decoration: const InputDecoration(labelText: 'Lokasi pemeriksaan'), items: ['Lab Medika','Klinik Sehat','Lab Sentosa'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => lab = v!)),
    const SizedBox(height: 12),
    Wrap(spacing: 8, children: ['09.00','11.00','13.00','15.00'].map((t) => ChoiceChip(label: Text(t), selected: selected == t, selectedColor: pale, onSelected: (_) => setState(() => selected = t)).copyWithLabelStyle()).toList()),
    const SizedBox(height: 18), AppButton(label: 'Pesan tes', icon: Icons.calendar_month, onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Konfirmasi pemesanan'), content: Text('Pilihan demo: $lab, pukul $selected. Hubungi penyedia layanan untuk jadwal dan biaya yang sebenarnya.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))]))),
  ]);
  Widget _labTile(String name, String price, String distance, IconData icon) => Card(color: Colors.white, child: ListTile(leading: CircleAvatar(backgroundColor: pale, child: Icon(icon, color: brand)), title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('$distance • $price'), trailing: const Icon(Icons.chevron_right), onTap: () => setState(() => lab = name)));
}

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});
  @override State<ConsultationScreen> createState() => _ConsultationScreenState();
}
class _ConsultationScreenState extends State<ConsultationScreen> {
  final input = TextEditingController();
  final messages = <String>['Halo! Saya ingin bertanya tentang persiapan donor darah.'];
  @override void dispose() { input.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Konsultasi medis')),
    body: Column(children: [
      Container(color: Colors.white, padding: const EdgeInsets.all(14), child: const Row(children: [CircleAvatar(backgroundColor: pale, child: Icon(Icons.medical_services, color: brand)), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Tim Medis LifeGift', style: TextStyle(fontWeight: FontWeight.bold)), Text('Simulasi konsultasi • tidak real-time', style: TextStyle(color: green, fontSize: 12))])])),
      Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: const Text('Selamat datang. Untuk pertanyaan medis yang menentukan kelayakan donor, konsultasikan langsung dengan tenaga kesehatan berwenang.')),
        ...messages.map((m) => Align(alignment: Alignment.centerRight, child: Container(margin: const EdgeInsets.only(top: 12), padding: const EdgeInsets.all(12), constraints: const BoxConstraints(maxWidth: 290), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(14)), child: Text(m)))),
      ])),
      SafeArea(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
        Expanded(child: TextField(controller: input, decoration: const InputDecoration(hintText: 'Tulis pertanyaan...', contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)))),
        const SizedBox(width: 8), IconButton.filled(onPressed: () { if (input.text.trim().isNotEmpty) { setState(() { messages.add(input.text.trim()); input.clear(); }); } }, icon: const Icon(Icons.send), style: IconButton.styleFrom(backgroundColor: brand)),
      ]))),
    ]));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Profil saya', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ink)),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)), child: const Column(children: [
      CircleAvatar(radius: 40, backgroundColor: pale, child: Icon(Icons.person, size: 44, color: brand)),
      SizedBox(height: 12), Text('Sahabat LifeGift', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text('anggota.demo@lifegift.id', style: TextStyle(color: Colors.black54)),
      SizedBox(height: 12), Chip(avatar: Icon(Icons.verified_outlined, color: brand), label: Text('Calon Pendonor')),
    ])),
    const SizedBox(height: 18), const SectionTitle('Kontribusi saya'),
    const Row(children: [Expanded(child: StatCard(icon: Icons.bloodtype, value: '0', label: 'Donor darah')), SizedBox(width: 10), Expanded(child: StatCard(icon: Icons.favorite, value: '0', label: 'Ikrar organ')), SizedBox(width: 10), Expanded(child: StatCard(icon: Icons.military_tech, value: '1', label: 'Badge'))]),
    const SizedBox(height: 18), const SectionTitle('Riwayat & pengaturan'),
    const InfoRow(icon: Icons.history, title: 'Riwayat aktivitas', value: 'Belum ada aktivitas nyata'),
    const InfoRow(icon: Icons.notifications_active_outlined, title: 'Pengingat donor ulang', value: 'Belum dijadwalkan'),
    const InfoRow(icon: Icons.privacy_tip_outlined, title: 'Privasi data', value: 'Jangan masukkan data medis asli pada demo'),
    AppButton(label: 'Konsultasi medis', icon: Icons.chat, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConsultationScreen()))),
    const SizedBox(height: 10), AppButton(label: 'Keluar', outlined: true, onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const WelcomeScreen()), (route) => false)),
  ]);
}

extension ChoiceChipStyle on ChoiceChip {
  ChoiceChip copyWithLabelStyle() => this;
}
