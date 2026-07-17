import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class CreateDailyPlanScreen extends ConsumerStatefulWidget {
  const CreateDailyPlanScreen({super.key});

  @override
  ConsumerState<CreateDailyPlanScreen> createState() =>
      _CreateDailyPlanScreenState();
}

class _CreateDailyPlanScreenState extends ConsumerState<CreateDailyPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _outcomeController = TextEditingController();
  final _lowEnergyController = TextEditingController();
  final _actionControllers = List.generate(3, (_) => TextEditingController());
  bool _saving = false;

  @override
  void dispose() {
    _outcomeController.dispose();
    _lowEnergyController.dispose();
    for (final controller in _actionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil untuk hari ini'),
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.generous,
            AppSpacing.standard,
            AppSpacing.generous,
            AppSpacing.screen,
          ),
          children: [
            const AppEyebrow('Mulai bersih'),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Apa satu hal yang layak selesai hari ini?',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Tidak ada utang dari kemarin. Pilih hasil yang cukup konkret untuk kamu Ship nanti.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            TextFormField(
              controller: _outcomeController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Satu hasil hari ini',
                hintText: 'Contoh: terbitkan video tutorial pertama',
                alignLabelWithHint: true,
              ),
              validator: _required,
            ),
            const SizedBox(height: AppSpacing.major),
            const AppSectionHeader(
              title: 'Buat jalan yang pendek',
              description:
                  'Langkah pertama wajib; dua berikutnya boleh kosong.',
            ),
            const SizedBox(height: AppSpacing.standard),
            for (var index = 0; index < _actionControllers.length; index++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    margin: const EdgeInsets.only(top: AppSpacing.compact),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? AppColors.accent
                          : AppColors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(AppRadius.small),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: AppTextStyles.number.copyWith(
                        color: index == 0
                            ? AppColors.textInverse
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.innerCompact),
                  Expanded(
                    child: TextFormField(
                      controller: _actionControllers[index],
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: index == 2
                          ? TextInputAction.done
                          : TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: index == 0
                            ? 'Mulai dari sini'
                            : 'Langkah ${index + 1} (opsional)',
                      ),
                      validator: index == 0 ? _required : null,
                    ),
                  ),
                ],
              ),
              if (index < 2) const SizedBox(height: AppSpacing.innerCompact),
            ],
            const SizedBox(height: AppSpacing.section),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.warningSoft,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.standard),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const AppIconBadge(
                          icon: Icons.battery_2_bar_rounded,
                          foreground: AppColors.warning,
                          background: AppColors.surface,
                          size: 42,
                        ),
                        const SizedBox(width: AppSpacing.innerCompact),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Siapkan versi energi rendah',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Opsional, tetapi berguna saat hari terasa berat.',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.innerCompact),
                    TextFormField(
                      controller: _lowEnergyController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Versi paling kecil',
                        hintText: 'Contoh: tulis satu paragraf',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomActionBar(
        child: FilledButton.icon(
          onPressed: _saving ? null : _save,
          icon: _saving
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.textInverse,
                  ),
                )
              : const Icon(Icons.arrow_forward_rounded),
          label: Text(_saving ? 'Menyiapkan…' : 'Gunakan rencana ini'),
        ),
      ),
    );
  }

  String? _required(String? value) {
    return value == null || value.trim().isEmpty ? 'Wajib diisi.' : null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _saving = true);
    try {
      await ref
          .read(trackerRepositoryProvider)
          .createDailyPlan(
            CreateDailyPlanInput(
              planDate: DateTime.now(),
              requiredOutcome: _outcomeController.text,
              actions: _actionControllers
                  .map((controller) => controller.text.trim())
                  .where((value) => value.isNotEmpty)
                  .toList(growable: false),
              lowEnergyAction: _lowEnergyController.text,
            ),
          );
      ref.invalidate(todayProvider);
      if (mounted) context.go('/today');
    } on AppException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
