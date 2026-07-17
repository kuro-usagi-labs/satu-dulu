import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/today/presentation/widgets/today_widgets.dart';

class ShipDraft {
  const ShipDraft({
    required this.title,
    required this.isPartial,
    this.externalUrl,
    this.evidenceNote,
  });

  final String title;
  final bool isPartial;
  final String? externalUrl;
  final String? evidenceNote;
}

class ShipSheet extends StatefulWidget {
  const ShipSheet({
    required this.initialTitle,
    required this.initiallyPartial,
    super.key,
  });

  final String initialTitle;
  final bool initiallyPartial;

  @override
  State<ShipSheet> createState() => _ShipSheetState();
}

class _ShipSheetState extends State<ShipSheet> {
  late final TextEditingController _titleController;
  final _urlController = TextEditingController();
  final _noteController = TextEditingController();
  late bool _partial;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _partial = widget.initiallyPartial;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.generous,
          0,
          AppSpacing.generous,
          MediaQuery.viewInsetsOf(context).bottom + AppSpacing.section,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppEyebrow('Tutup lingkaran hari ini'),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Apa yang benar-benar kamu kirim?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Ship berarti hasil sudah keluar dari kepala: selesai, diterbitkan, dikirim, atau diuji.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            TextField(
              controller: _titleController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Hasil yang dikirim',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            DecoratedBox(
              decoration: BoxDecoration(
                color: _partial
                    ? AppColors.warningSoft
                    : AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
              child: Material(
                color: Colors.transparent,
                child: CheckboxListTile(
                  value: _partial,
                  onChanged: (value) =>
                      setState(() => _partial = value ?? false),
                  title: const Text('Ini versi kecil'),
                  subtitle: const Text(
                    'Tetap bergerak tanpa menyebut hari ini gagal.',
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.innerCompact,
                    vertical: AppSpacing.micro,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(
                bottom: AppSpacing.standard,
              ),
              title: const Text('Tambahkan bukti (opsional)'),
              subtitle: const Text('Tautan atau catatan singkat'),
              children: [
                TextField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Tautan hasil',
                    hintText: 'https://…',
                  ),
                ),
                const SizedBox(height: AppSpacing.innerCompact),
                TextField(
                  controller: _noteController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan bukti',
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.compact),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.arrow_outward_rounded),
              label: const Text('Simpan Ship Hari Ini'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tuliskan hasil yang kamu kirim.')),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    Navigator.pop(
      context,
      ShipDraft(
        title: title,
        isPartial: _partial,
        externalUrl: _emptyToNull(_urlController.text),
        evidenceNote: _emptyToNull(_noteController.text),
      ),
    );
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

class ShipSuccessSheet extends StatelessWidget {
  const ShipSuccessSheet({required this.outputTitle, super.key});

  final String outputTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.generous,
          0,
          AppSpacing.generous,
          AppSpacing.section,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppIconBadge(
              icon: Icons.check_rounded,
              foreground: AppColors.textInverse,
              background: AppColors.success,
              size: 58,
            ),
            const SizedBox(height: AppSpacing.section),
            Text(
              'Hari ini sudah punya bukti.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              outputTitle,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.add_chart_rounded),
              label: const Text('Catat angka hasil'),
            ),
            const SizedBox(height: AppSpacing.compact),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Selesai untuk hari ini'),
            ),
          ],
        ),
      ),
    );
  }
}

enum RecoveryChoice { start, guide }

class RecoverySheet extends StatelessWidget {
  const RecoverySheet({
    required this.today,
    required this.lowEnergy,
    super.key,
  });

  final TodayOverview today;
  final bool lowEnergy;

  @override
  Widget build(BuildContext context) {
    final nextAction =
        today.actions.where((action) => !action.isCompleted).firstOrNull ??
        today.actions.firstOrNull;
    final smallestAction =
        lowEnergy && today.lowEnergyAction?.isNotEmpty == true
        ? today.lowEnergyAction!
        : nextAction?.label ?? today.requiredOutcome;
    final hasGuide =
        (today.linkedGuideDocumentId ?? today.project.primaryGuideDocumentId) !=
        null;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.generous,
          0,
          AppSpacing.generous,
          AppSpacing.section,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppEyebrow('Kembali ke arah'),
            const SizedBox(height: AppSpacing.compact),
            Text(
              today.project.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.section),
            RecoveryItem(
              label: 'Tujuan 30 hari',
              value: today.project.shortGoal,
            ),
            if (today.project.whyChosen?.isNotEmpty == true) ...[
              const SizedBox(height: AppSpacing.standard),
              RecoveryItem(
                label: 'Kenapa kamu memilih ini',
                value: today.project.whyChosen!,
              ),
            ],
            const SizedBox(height: AppSpacing.standard),
            RecoveryItem(label: 'Hasil hari ini', value: today.requiredOutcome),
            const SizedBox(height: AppSpacing.section),
            RecoveryItem(
              label: 'Lakukan ini saja sekarang',
              value: smallestAction,
              emphasized: true,
            ),
            const SizedBox(height: AppSpacing.section),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context, RecoveryChoice.start),
              icon: const Icon(Icons.arrow_downward_rounded),
              label: const Text('Kerjakan sekarang'),
            ),
            if (hasGuide) ...[
              const SizedBox(height: AppSpacing.compact),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context, RecoveryChoice.guide),
                icon: const Icon(Icons.menu_book_rounded),
                label: const Text('Buka panduan arah'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
