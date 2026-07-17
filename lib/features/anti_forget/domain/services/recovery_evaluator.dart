import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';

abstract final class RecoveryEvaluator {
  static RecoveryBrief evaluate(RecoverySnapshot snapshot) {
    final project = snapshot.project;
    if (project == null) return const RecoveryBrief.none();

    if (!snapshot.hasActiveSprint) {
      return RecoveryBrief(
        severity: RecoverySeverity.urgent,
        reason: RecoveryReason.missingSprint,
        title: 'Fokusmu butuh jalur baru',
        message:
            'Proyek ${project.name} masih menjadi fokus, tetapi tidak punya sprint aktif yang sehat.',
        primaryActionLabel: 'Buka proyek',
        secondaryActionLabel: 'Lihat konteks terakhir',
        suggestedAction: snapshot.capsule?.nextAction,
      );
    }

    if (_reviewIsDue(project.reviewDate, snapshot.now)) {
      return RecoveryBrief(
        severity: RecoverySeverity.urgent,
        reason: RecoveryReason.reviewDue,
        title: 'Berhenti sebentar untuk memilih arah',
        message:
            'Putaran ${project.name} sudah waktunya ditinjau. Gunakan bukti sebelum menambah rencana baru.',
        primaryActionLabel: 'Review sekarang',
        secondaryActionLabel: 'Lihat hasil',
        suggestedAction: snapshot.capsule?.nextAction,
      );
    }

    if (!snapshot.hasTodayPlan && snapshot.now.hour >= 12) {
      return RecoveryBrief(
        severity: RecoverySeverity.gentle,
        reason: RecoveryReason.noPlanAfterNoon,
        title: 'Hari mulai ramai, arah belum dipilih',
        message:
            'Jangan mengejar semua proyek. Tentukan satu hasil kecil untuk ${project.name}.',
        primaryActionLabel: 'Buat rencana kecil',
        secondaryActionLabel: 'Lihat konteks terakhir',
        suggestedAction: snapshot.capsule?.nextAction,
      );
    }

    final lastShip = snapshot.lastShippedAt?.toLocal();
    if (!snapshot.shippedToday && lastShip != null) {
      final lastShipDay = DateTime(lastShip.year, lastShip.month, lastShip.day);
      final nowDay = DateTime(
        snapshot.now.year,
        snapshot.now.month,
        snapshot.now.day,
      );
      if (nowDay.difference(lastShipDay).inDays >= 2) {
        return RecoveryBrief(
          severity: RecoverySeverity.urgent,
          reason: RecoveryReason.noShipTwoDays,
          title: 'Ritmemu mulai terputus',
          message:
              'Sudah dua hari atau lebih tanpa hasil terkirim. Kecilkan ukuran kerja, jangan ganti proyek dulu.',
          primaryActionLabel: snapshot.hasTodayPlan
              ? 'Kerjakan langkah terkecil'
              : 'Buat rencana 10 menit',
          secondaryActionLabel: 'Buka panduan atau capsule',
          suggestedAction: snapshot.capsule?.nextAction,
        );
      }
    }

    final checkIn = snapshot.checkIn;
    if (checkIn?.energyLevel == EnergyLevel.low &&
        checkIn!.availableMinutes <= 30 &&
        snapshot.todayActionCount > 1 &&
        !snapshot.shippedToday) {
      return RecoveryBrief(
        severity: RecoverySeverity.gentle,
        reason: RecoveryReason.lowEnergyOversizedPlan,
        title: 'Rencananya lebih besar dari energimu',
        message:
            'Hari ini hanya punya ${checkIn.capacityLabel}. Pilih satu tindakan yang menjaga arah.',
        primaryActionLabel: 'Pakai mode energi rendah',
        secondaryActionLabel: 'Ubah check-in',
        suggestedAction: snapshot.capsule?.nextAction,
      );
    }

    return const RecoveryBrief.none();
  }

  static bool _reviewIsDue(DateTime? reviewDate, DateTime now) {
    if (reviewDate == null) return false;
    final local = reviewDate.toLocal();
    final reviewDay = DateTime(local.year, local.month, local.day);
    final today = DateTime(now.year, now.month, now.day);
    return !reviewDay.isAfter(today);
  }
}
