import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
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
        title: const Text('Rencana hari ini'),
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.generous),
          children: [
            Text(
              'Tidak ada utang tugas dari kemarin.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Tentukan satu hasil untuk hari ini dan pecah menjadi paling banyak tiga tindakan.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            TextFormField(
              controller: _outcomeController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Hasil wajib hari ini',
              ),
              validator: _required,
            ),
            const SizedBox(height: AppSpacing.standard),
            for (var index = 0; index < _actionControllers.length; index++) ...[
              TextFormField(
                controller: _actionControllers[index],
                decoration: InputDecoration(
                  labelText:
                      'Tindakan ${index + 1}${index == 0 ? '' : ' (opsional)'}',
                ),
                validator: index == 0 ? _required : null,
              ),
              const SizedBox(height: AppSpacing.innerCompact),
            ],
            TextFormField(
              controller: _lowEnergyController,
              decoration: const InputDecoration(
                labelText: 'Langkah saat energi rendah',
              ),
            ),
            const SizedBox(height: AppSpacing.section),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Gunakan rencana ini'),
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) {
    return value == null || value.trim().isEmpty ? 'Wajib diisi.' : null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
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
