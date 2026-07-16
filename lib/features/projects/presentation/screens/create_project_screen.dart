import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class CreateProjectScreen extends ConsumerStatefulWidget {
  const CreateProjectScreen({required this.onboarding, super.key});

  final bool onboarding;

  @override
  ConsumerState<CreateProjectScreen> createState() =>
      _CreateProjectScreenState();
}

class _CreateProjectScreenState extends ConsumerState<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _goalController = TextEditingController();
  final _whyController = TextEditingController();
  final _successController = TextEditingController();
  final _outcomeController = TextEditingController();
  final _lowEnergyController = TextEditingController();
  final _actionControllers = List.generate(3, (_) => TextEditingController());

  ProjectStatus _status = ProjectStatus.focus;
  bool _saving = false;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onboarding ? 'Fokus pertamamu' : 'Proyek baru'),
        leading: widget.onboarding
            ? null
            : IconButton(
                onPressed: context.pop,
                tooltip: 'Kembali',
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.generous,
            AppSpacing.compact,
            AppSpacing.generous,
            AppSpacing.screen,
          ),
          children: [
            _FormSection(
              title: 'Identitas',
              children: [
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nama proyek',
                    hintText: 'Contoh: Channel tutorial Flutter',
                  ),
                  validator: _required('Nama proyek'),
                ),
                const SizedBox(height: AppSpacing.innerCompact),
                TextFormField(
                  controller: _goalController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Tujuan',
                    hintText: 'Apa yang ingin kamu buktikan?',
                  ),
                  validator: _required('Tujuan'),
                ),
                const SizedBox(height: AppSpacing.innerCompact),
                TextFormField(
                  controller: _whyController,
                  textInputAction: TextInputAction.next,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Kenapa dipilih?',
                    hintText: 'Alasan proyek ini penting sekarang',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.standard),
            _FormSection(
              title: 'Eksperimen 30 hari',
              children: [
                TextFormField(
                  controller: _successController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Definisi berhasil',
                    hintText:
                        'Bukti apa yang membuat eksperimen ini layak dilanjutkan?',
                  ),
                ),
                const SizedBox(height: AppSpacing.innerCompact),
                TextFormField(
                  controller: _outcomeController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Hasil wajib hari ini',
                    hintText: 'Satu hasil yang bisa benar-benar di-ship',
                  ),
                  validator: _required('Hasil wajib hari ini'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.standard),
            _FormSection(
              title: 'Maksimal tiga tindakan',
              children: [
                for (
                  var index = 0;
                  index < _actionControllers.length;
                  index++
                ) ...[
                  TextFormField(
                    controller: _actionControllers[index],
                    textInputAction: index == 2
                        ? TextInputAction.done
                        : TextInputAction.next,
                    decoration: InputDecoration(
                      labelText:
                          'Tindakan ${index + 1}${index == 0 ? '' : ' (opsional)'}',
                    ),
                    validator: index == 0
                        ? _required('Tindakan pertama')
                        : null,
                  ),
                  if (index < 2)
                    const SizedBox(height: AppSpacing.innerCompact),
                ],
                const SizedBox(height: AppSpacing.innerCompact),
                TextFormField(
                  controller: _lowEnergyController,
                  decoration: const InputDecoration(
                    labelText: 'Langkah saat energi rendah',
                    hintText: 'Kecilkan langkahnya, jangan hilangkan arahnya',
                  ),
                ),
              ],
            ),
            if (!widget.onboarding) ...[
              const SizedBox(height: AppSpacing.standard),
              _FormSection(
                title: 'Status',
                children: [
                  SegmentedButton<ProjectStatus>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: ProjectStatus.focus,
                        label: Text('Focus'),
                      ),
                      ButtonSegment(
                        value: ProjectStatus.maintenance,
                        label: Text('Maintenance'),
                      ),
                      ButtonSegment(
                        value: ProjectStatus.parkingLot,
                        label: Text('Parking Lot'),
                      ),
                    ],
                    selected: {_status},
                    onSelectionChanged: (selection) {
                      setState(() => _status = selection.single);
                    },
                  ),
                ],
              ),
            ],
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
                  : Text(widget.onboarding ? 'Mulai 30 hari' : 'Simpan proyek'),
            ),
          ],
        ),
      ),
    );
  }

  FormFieldValidator<String> _required(String label) => (value) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi.';
    return null;
  };

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
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
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<ProjectStatus?> _showStatusConflict(
    Project existing,
    ProjectStatus requested,
  ) {
    final isFocus = requested == ProjectStatus.focus;
    return showDialog<ProjectStatus>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isFocus ? 'Fokus utama sudah ada' : 'Maintenance sudah ada',
        ),
        content: Text(
          isFocus
              ? 'Jika proyek baru menjadi fokus, “${existing.name}” dipindahkan ke Parking Lot.'
              : 'Jika proyek baru menjadi maintenance, “${existing.name}” dipindahkan ke Parking Lot.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ProjectStatus.parkingLot),
            child: const Text('Simpan ke Parking Lot'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, requested),
            child: Text(isFocus ? 'Ganti fokus' : 'Ganti maintenance'),
          ),
        ],
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.standard),
            ...children,
          ],
        ),
      ),
    );
  }
}
