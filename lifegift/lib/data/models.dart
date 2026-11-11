/// Model data sederhana (immutable) untuk seluruh layar LifeGift.
class BloodRequest {
  const BloodRequest({
    required this.hospital,
    required this.bloodType,
    required this.distanceKm,
    required this.unitsNeeded,
    required this.patient,
    required this.deadlineHours,
    required this.mapX,
    required this.mapY,
  });

  final String hospital;
  final String bloodType; // contoh: O+
  final double distanceKm;
  final int unitsNeeded;
  final String patient;
  final int deadlineHours;

  /// Posisi penanda pada peta ilustrasi, rentang -1.0 .. 1.0
  /// (dipakai oleh Alignment sehingga otomatis responsif).
  final double mapX;
  final double mapY;
}

class LabOption {
  const LabOption({
    required this.name,
    required this.priceLabel,
    required this.distanceKm,
  });

  final String name;
  final String priceLabel;
  final double distanceKm;
}

class Doctor {
  const Doctor({
    required this.name,
    required this.specialty,
    required this.online,
    required this.avatarAsset,
  });

  final String name;
  final String specialty;
  final bool online;
  final String avatarAsset;
}

class ChatMessage {
  const ChatMessage({required this.text, required this.fromUser});

  final String text;
  final bool fromUser;
}

class DonationRecord {
  const DonationRecord({
    required this.date,
    required this.place,
    required this.volumeMl,
  });

  final String date;
  final String place;
  final int volumeMl;
}

class DonorBadge {
  const DonorBadge({required this.title, required this.caption});

  final String title;
  final String caption;
}
