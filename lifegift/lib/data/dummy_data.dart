import 'models.dart';

/// Data contoh (dummy) sesuai konten slide proposal.
/// Belum terhubung ke API; integrasi dilakukan pada tahap berikutnya.
class DummyData {
  DummyData._();

  static const String userName = 'Jaya';
  static const String userFirstName = 'Jaya';
  static const String userBloodType = 'O+';
  static const String registrationNo = 'LG-2026-00481';

  static const List<BloodRequest> requests = [
    BloodRequest(
      hospital: 'RS Adam Malik',
      bloodType: 'O+',
      distanceKm: 2.3,
      unitsNeeded: 2,
      patient: 'Ny. S',
      deadlineHours: 3,
      mapX: -0.35,
      mapY: -0.45,
    ),
    BloodRequest(
      hospital: 'PMI Kota Medan',
      bloodType: 'A+',
      distanceKm: 3.1,
      unitsNeeded: 3,
      patient: 'Tn. R',
      deadlineHours: 6,
      mapX: 0.55,
      mapY: -0.2,
    ),
    BloodRequest(
      hospital: 'RS Columbia Asia',
      bloodType: 'O+',
      distanceKm: 4.8,
      unitsNeeded: 1,
      patient: 'An. D',
      deadlineHours: 5,
      mapX: 0.3,
      mapY: 0.6,
    ),
  ];

  static const List<String> bloodTypeFilters = [
    'Semua',
    'O+',
    'A+',
    'B+',
    'AB+',
  ];

  static const List<String> organs = [
    'Ginjal',
    'Hati',
    'Jantung',
    'Kornea',
    'Paru-paru',
    'Pankreas',
  ];

  static const List<LabOption> labs = [
    LabOption(name: 'Prodia Medan', priceLabel: 'Rp 25.000', distanceKm: 1.2),
    LabOption(
      name: 'Lab Kimia Farma',
      priceLabel: 'Rp 30.000',
      distanceKm: 2.0,
    ),
    LabOption(name: 'Puskesmas Kota', priceLabel: 'Gratis', distanceKm: 3.4),
  ];

  static const List<String> labSchedules = [
    'Sen 10:00',
    'Sen 13:00',
    'Sel 09:00',
    'Sel 14:00',
  ];

  static const List<Doctor> doctors = [
    Doctor(
      name: 'dr. Maya Sari, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      online: true,
      avatarAsset: 'assets/images/doctor_maya.png',
    ),
    Doctor(
      name: 'dr. Budi Hartono',
      specialty: 'Dokter Umum',
      online: true,
      avatarAsset: 'assets/images/doctor_budi.png',
    ),
    Doctor(
      name: 'dr. Rina Lubis, Sp.JP',
      specialty: 'Spesialis Jantung',
      online: false,
      avatarAsset: 'assets/images/doctor_rina.png',
    ),
  ];

  static const List<ChatMessage> initialChat = [
    ChatMessage(
      text: 'Selamat siang, apakah saya boleh donor darah jika sedang minum obat tekanan darah?',
      fromUser: true,
    ),
    ChatMessage(
      text: 'Boleh jika tekanan darah terkontrol. Berapa tekanan darah terakhir Anda?',
      fromUser: false,
    ),
    ChatMessage(text: 'Sekitar 120/80 dok.', fromUser: true),
    ChatMessage(
      text: 'Baik, Anda memenuhi syarat. Jangan lupa cukup makan & minum sebelum donor.',
      fromUser: false,
    ),
  ];

  static const List<DonationRecord> history = [
    DonationRecord(date: '12 Jul 2026', place: 'PMI Medan', volumeMl: 350),
    DonationRecord(date: '10 Apr 2026', place: 'RS Adam Malik', volumeMl: 350),
  ];

  static const List<DonorBadge> badges = [
    DonorBadge(title: 'Pahlawan Pemula', caption: 'Donor pertama'),
    DonorBadge(title: 'Donor Rutin', caption: '3x donor berturut'),
    DonorBadge(title: 'Penyelamat', caption: '10+ nyawa terbantu'),
  ];
}
