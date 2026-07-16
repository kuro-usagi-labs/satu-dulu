import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class EditProjectScreen extends ConsumerWidget {
  const EditProjectScreen({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider(projectId));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Edit proyek'),
      ),
      body: project.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) =>
            const Center(child: Text('Proyek belum dapat dimuat.')),
        data: (value) => value == null
            ? const Center(child: Text('Proyek tidak ditemukan.'))
            : _EditProjectForm(project: value),
      ),
    );
  }
}

class _EditProjectForm extends ConsumerStatefulWidget {
  const _EditProjectForm({required this.project});

  final Project project;

  @override
  ConsumerState<_EditProjectForm> createState() => _EditProjectFormState();
}

class _EditProjectFormState extends ConsumerState<_EditProjectForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _goalController;
  late final TextEditingController _whyController;
  late final TextEditingController _successController;
  late ProjectStatus _status;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.name);
    _goalController = TextEditingController(text: widget.project.shortGoal);
    _whyController = TextEditingController(text: widget.project.whyChosen);
    _successController = TextEditingController(
      text: widget.project.successDefinition,
    );
    _status = widget.project.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _goalController.dispose();
    _whyController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.generous),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nama proyek'),
            validator: _required,
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          TextFormField(
            controller: _goalController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Tujuan'),
            validator: _required,
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          TextFormField(
            controller: _whyController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Kenapa dipilih?'),
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          TextFormField(
            controller: _successController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Definisi berhasil'),
          ),
          const SizedBox(height: AppSpacing.section),
          Text('Status', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.innerCompact),
          SegmentedButton<ProjectStatus>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: ProjectStatus.focus, label: Text('Focus')),
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
                : const Text('Simpan perubahan'),
          ),
        ],
      ),
    );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Wajib diisi.' : null;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repository = ref.read(trackerRepositoryProvider);
      var selectedStatus = _status;
      final conflict = selectedStatus == ProjectStatus.focus
          ? await repository.getFocusProject()
          : selectedStatus == ProjectStatus.maintenance
          ? await repository.getMaintenanceProject()
          : null;
      if (conflict != null && conflict.id != widget.project.id && mounted) {
        final replace = await _confirmReplacement(conflict, selectedStatus);
        if (replace == null) return;
        selectedStatus = replace ? selectedStatus : ProjectStatus.parkingLot;
      }
      await repository.updateProject(
        widget.project.id,
        UpdateProjectInput(
          name: _nameController.text,
          shortGoal: _goalController.text,
          whyChosen: _whyController.text,
          successDefinition: _successController.text,
          status: selectedStatus,
          targetRevenueMinor: widget.project.targetRevenueMinor,
        ),
      );
      ref.invalidate(projectsProvider);
      ref.invalidate(projectProvider(widget.project.id));
      ref.invalidate(todayProvider);
      if (mounted) context.go('/projects/${widget.project.id}');
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

  Future<bool?> _confirmReplacement(Project existing, ProjectStatus status) {
    final label = status == ProjectStatus.focus ? 'focus' : 'maintenance';
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${label[0].toUpperCase()}${label.substring(1)} sudah ada'),
        content: Text(
          '“${existing.name}” akan dipindahkan ke Parking Lot jika proyek ini menjadi $label.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Simpan ke Parking Lot'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ganti'),
          ),
        ],
      ),
    );
  }
}
