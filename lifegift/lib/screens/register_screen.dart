import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/common_widgets.dart';
import 'app_shell.dart';

/// LAYAR 02 - Daftar & Skrining Awal (slide 11).
///
/// [Ketentuan 1] Scaffold + AppBar + body.
/// [Ketentuan 5] Padding, SizedBox, Container.
/// [Ketentuan 6] Column, Row, Expanded.
/// [Ketentuan 7] LayoutBuilder: field golongan darah & Rhesus
///               berdampingan di layar lebar, bertumpuk di layar sempit.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _contactCtrl = TextEditingController();
  final TextEditingController _historyCtrl = TextEditingController();

  static const List<String> _bloodTypes = ['A', 'B', 'AB', 'O'];
  String _bloodType = 'O';
  String _rhesus = 'positif';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _contactCtrl.dispose();
    _historyCtrl.dispose();
    super.dispose();
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().length < 3) return 'Nama minimal 3 karakter';
    return null;
  }

  String? _validateContact(String? v) {
    final String s = (v ?? '').trim();
    final bool isEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
    final bool isPhone = RegExp(r'^(\+62|62|0)8[0-9]{8,12}$').hasMatch(s);
    if (!isEmail && !isPhone) return 'Masukkan email atau No. HP yang valid';
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const AppShell()),
        (route) => false,
      );
    } else {
      showInfoSnack(context, 'Lengkapi data yang masih salah.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat akun & skrining')),
      body: SingleChildScrollView(
        child: ResponsiveBody(
          maxWidth: 560,
          child: Form(
            key: _formKey,
            // Validasi real-time: berjalan begitu pengguna berinteraksi.
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Isi data dasar dan data medis singkat agar sistem dapat '
                  'mencocokkan permintaan donor dengan tepat.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: Spacing.lg),
                const FieldLabel('Nama lengkap'),
                TextFormField(
                  controller: _nameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Nama',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: _validateName,
                ),
                const SizedBox(height: Spacing.md),
                const FieldLabel('Email / No. HP'),
                TextFormField(
                  controller: _contactCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Nama@email.com',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: _validateContact,
                ),
                const SizedBox(height: Spacing.md),
                // Golongan darah + Rhesus: adaptif terhadap lebar tersedia.
                LayoutBuilder(
                  builder: (context, constraints) {
                    final Widget blood = _bloodTypePicker();
                    final Widget rhesus = _rhesusPicker();
                    if (constraints.maxWidth >= 480) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: blood),
                          const SizedBox(width: Spacing.lg),
                          Expanded(child: rhesus),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        blood,
                        const SizedBox(height: Spacing.md),
                        rhesus,
                      ],
                    );
                  },
                ),
                const SizedBox(height: Spacing.md),
                const FieldLabel('Riwayat penyakit'),
                TextFormField(
                  controller: _historyCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Tidak ada',
                    prefixIcon: Icon(Icons.medical_information_outlined),
                  ),
                ),
                const SizedBox(height: Spacing.xl),
                PrimaryActionButton(label: 'Lanjutkan', onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bloodTypePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel('Golongan darah'),
        Wrap(
          spacing: Spacing.sm,
          runSpacing: Spacing.sm,
          children: [
            for (final String t in _bloodTypes)
              ChoiceChip(
                label: Text(t),
                selected: _bloodType == t,
                selectedColor: AppColors.roseTint,
                onSelected: (_) => setState(() => _bloodType = t),
              ),
          ],
        ),
      ],
    );
  }

  Widget _rhesusPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel('Rhesus'),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment<String>(value: 'positif', label: Text('Positif (+)')),
            ButtonSegment<String>(value: 'negatif', label: Text('Negatif (-)')),
          ],
          selected: {_rhesus},
          onSelectionChanged: (s) => setState(() => _rhesus = s.first),
        ),
      ],
    );
  }
}
