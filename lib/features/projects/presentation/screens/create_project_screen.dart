import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/projects/presentation/widgets/project_setup_steps.dart';

class CreateProjectScreen extends ConsumerStatefulWidget {
  const CreateProjectScreen({required this.onboarding, super.key});

  final bool onboarding;

  @override
  ConsumerState<CreateProjectScreen> createState() =>
      _CreateProjectScreenState();
}

class _CreateProjectScreenState extends ConsumerState<CreateProjectScreen> {
  final _stepKeys = List.generate(3, (_) => GlobalKey<FormState>());
  final _nameController = TextEditingController();
  final _goalController = TextEditingController();
  final _whyController = TextEditingController();
  final _successController = TextEditingController();
  final _outcomeController = TextEditingController();
  final _lowEnergyController = TextEditingController();
  final _actionControllers = List.generate(3, (_) => TextEditingController());

  ProjectStatus _status = ProjectStatus.focus;
  int _step = 0;
  bool _saving = false;

  static const _titles = [
    'Pilih yang layak dikejar sekarang',
    'Tentukan garis akhirnya',
    'Buat jalur hari pertama',
  ];

  static const _descriptions = [
    'Nama yang jelas dan alasan yang jujur akan memudahkanmu kembali saat perhatian mulai pecah.',
    'Kamu tidak perlu menjamin sukses. Tentukan bukti yang ingin dicari dalam 30 hari.',
    'Satu hasil, maksimal tiga langkah, plus versi kecil ketika energimu rendah.',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _goalController.dispose();
    _whyController.dispose();
    _successController.dispose();
    _outcomeController.dispose();
    _lowEnergyController.dispose();
    for (final controller in _actionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return PopScope(
      canPop: _step == 0 && !widget.onboarding,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _step > 0) _previousStep();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _step > 0 || !widget.onboarding
              ? IconButton(
                  onPressed: _step > 0 ? _previousStep : context.pop,
                  tooltip: _step > 0 ? 'Langkah sebelumnya' : 'Kembali',
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                )
              : null,
          title: Text(widget.onboarding ? 'Siapkan fokusmu' : 'Proyek baru'),
        ),
        body: _buildStep(reduceMotion),
        bottomNavigationBar: AppBottomActionBar(
          child: Row(
            children: [
              if (_step > 0) ...[
                TextButton(
                  onPressed: _saving ? null : _previousStep,
                  child: const Text('Kembali'),
                ),
                const SizedBox(width: AppSpacing.compact),
              ],
              Expanded(
                child: FilledButton.icon(
                  onPressed: _saving ? null : _continue,
                  icon: _saving
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textInverse,
                          ),
                        )
                      : Icon(
                          _step == 2
                              ? Icons.flag_rounded
                              : Icons.arrow_forward_rounded,
                        ),
                  label: Text(
                    _saving
                        ? 'Menyiapkan…'
                        : _step == 2
                        ? widget.onboarding
                              ? 'Mulai 30 hari'
                              : 'Simpan proyek'
                        : 'Lanjut',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(bool reduceMotion) {
    final child = switch (_step) {
      0 => ProjectIdentityStep(
        nameController: _nameController,
        goalController: _goalController,
        whyController: _whyController,
        nameValidator: _required('Nama fokus'),
        goalValidator: _required('Tujuan'),
      ),
      1 => ProjectFinishLineStep(
        successController: _successController,
        outcomeController: _outcomeController,
        outcomeValidator: _required('Hasil hari ini'),
      ),
      _ => ProjectFirstDayStep(
        actionControllers: _actionControllers,
        lowEnergyController: _lowEnergyController,
        firstActionValidator: _required('Langkah pertama'),
        showStatusOptions: !widget.onboarding,
        selectedStatus: _status,
        onStatusSelected: _selectStatus,
      ),
    };

    return Form(
      key: _stepKeys[_step],
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.generous,
          AppSpacing.compact,
          AppSpacing.generous,
          AppSpacing.screen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: AppEyebrow('Langkah ${_step + 1} dari 3')),
                const SizedBox(width: AppSpacing.compact),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0; index < 3; index++) ...[
                      AnimatedContainer(
                        duration: reduceMotion
                            ? Duration.zero
                            : AppDuration.stateChange,
                        width: index == _step ? 26 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index <= _step
                              ? AppColors.accent
                              : AppColors.border,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      if (index < 2) const SizedBox(width: AppSpacing.compact),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            AnimatedSwitcher(
              duration: reduceMotion ? Duration.zero : AppDuration.stateChange,
              child: Column(
                key: ValueKey(_step),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _titles[_step],
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.compact),
                  Text(
                    _descriptions[_step],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.section),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.section),
            child,
          ],
        ),
      ),
    );
  }

  FormFieldValidator<String> _required(String label) => (value) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi.';
    return null;
  };

  void _selectStatus(ProjectStatus value) => setState(() => _status = value);

  void _previousStep() {
    FocusScope.of(context).unfocus();
    if (_step > 0) setState(() => _step--);
  }

  void _continue() {
    FocusScope.of(context).unfocus();
    if (!(_stepKeys[_step].currentState?.validate() ?? false)) return;
    if (_step < 2) {
      setState(() => _step++);
    } else {
      _save();
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);

    try {
      final repository = ref.read(trackerRepositoryProvider);
      var status = _status;
      final existing = status == ProjectStatus.focus
          ? await repository.getFocusProject()
          : status == ProjectStatus.maintenance
          ? await repository.getMaintenanceProject()
          : null;

      if (existing != null && mounted) {
        final resolution = await _showStatusConflict(existing, status);
        if (resolution == null) return;
        status = resolution;
      }

      await repository.createProject(
        CreateProjectInput(
          name: _nameController.text,
          shortGoal: _goalController.text,
          whyChosen: _whyController.text,
          successDefinition: _successController.text,
          status: status,
          startDate: DateTime.now(),
          requiredOutcome: _outcomeController.text,
          actions: _actionControllers
              .map((controller) => controller.text.trim())
              .where((value) => value.isNotEmpty)
              .toList(growable: false),
          lowEnergyAction: _lowEnergyController.text,
        ),
      );
      ref.invalidate(projectsProvider);
      ref.invalidate(todayProvider);
      if (mounted) {
        context.go(status == ProjectStatus.focus ? '/today' : '/projects');
      }
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

  Future<ProjectStatus?> _showStatusConflict(
    Project existing,
    ProjectStatus requested,
  ) {
    final isFocus = requested == ProjectStatus.focus;
    final requestedLabel = isFocus ? 'fokus utama' : 'tetap dijaga';
    return showDialog<ProjectStatus>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(isFocus ? Icons.adjust_rounded : Icons.spa_outlined),
        title: Text(
          '${isFocus ? 'Fokus utama' : 'Proyek yang dijaga'} sudah ada',
        ),
        content: Text(
          'Jika proyek baru menjadi $requestedLabel, “${existing.name}” akan dipindahkan ke Disimpan dulu.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ProjectStatus.parkingLot),
            child: const Text('Simpan proyek baru dulu'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, requested),
            child: Text(isFocus ? 'Ganti fokus' : 'Ganti yang dijaga'),
          ),
        ],
      ),
    );
  }
}
