import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
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
        title: const Text('Edit arah proyek'),
      ),
      body: project.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.generous),
          child: Column(
            children: [
              AppLoadingBlock(height: 128),
              SizedBox(height: AppSpacing.standard),
              AppLoadingBlock(height: 220),
            ],
          ),
        ),
        error: (error, stackTrace) => _EditLoadError(
          onRetry: () => ref.invalidate(projectProvider(projectId)),
        ),
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
    final statusPalette = _statusPalette(_status);
    return Scaffold(
      backgroundColor: Colors.transparent,
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
            const AppEyebrow('Perjelas, jangan perluas'),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Ubah arah tanpa kehilangan buktinya.',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Riwayat Ship, hasil, dan panduan tetap terhubung ke proyek ini.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Nama proyek'),
              validator: _required,
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            TextFormField(
              controller: _goalController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Tujuan 30 hari',
                alignLabelWithHint: true,
              ),
              validator: _required,
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            TextFormField(
              controller: _whyController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Kenapa ini penting sekarang?',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            TextFormField(
              controller: _successController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Bukti yang ingin dicari',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: AppSpacing.major),
            const AppSectionHeader(
              title: 'Tempat proyek',
              description:
                  'Status mengatur seberapa besar perhatian yang ia ambil.',
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            DropdownButtonFormField<ProjectStatus>(
              initialValue: _status,
              decoration: const InputDecoration(labelText: 'Peran proyek'),
              items: const [
                DropdownMenuItem(
                  value: ProjectStatus.focus,
                  child: Text('Fokus utama'),
                ),
                DropdownMenuItem(
                  value: ProjectStatus.maintenance,
                  child: Text('Tetap dijaga'),
                ),
                DropdownMenuItem(
                  value: ProjectStatus.parkingLot,
                  child: Text('Disimpan dulu'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _status = value);
              },
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            AppNotice(
              icon: _statusIcon(_status),
              title: _statusLabel(_status),
              description: _statusDescription(_status),
              background: statusPalette.soft,
              foreground: statusPalette.strong,
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
                    color: AppColors.onAction,
                  ),
                )
              : const Icon(Icons.check_rounded),
          label: Text(_saving ? 'Menyimpan…' : 'Simpan perubahan'),
        ),
      ),
    );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Wajib diisi.' : null;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
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
    final label = _statusLabel(status).toLowerCase();
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(_statusIcon(status)),
        title: Text('${_statusLabel(status)} sudah ada'),
        content: Text(
          '“${existing.name}” akan dipindahkan ke Disimpan dulu jika proyek ini menjadi $label.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Simpan proyek ini dulu'),
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

String _statusLabel(ProjectStatus status) => switch (status) {
  ProjectStatus.focus => 'Fokus utama',
  ProjectStatus.maintenance => 'Tetap dijaga',
  ProjectStatus.parkingLot => 'Disimpan dulu',
  ProjectStatus.archived => 'Diarsipkan',
};

IconData _statusIcon(ProjectStatus status) => switch (status) {
  ProjectStatus.focus => Icons.adjust_rounded,
  ProjectStatus.maintenance => Icons.spa_outlined,
  ProjectStatus.parkingLot => Icons.inventory_2_outlined,
  ProjectStatus.archived => Icons.archive_outlined,
};

String _statusDescription(ProjectStatus status) => switch (status) {
  ProjectStatus.focus => 'Memimpin 30 hari dan muncul di Hari Ini.',
  ProjectStatus.maintenance =>
    'Tetap hidup, tetapi tidak mengambil alih Hari Ini.',
  ProjectStatus.parkingLot =>
    'Aman untuk nanti dan tidak memecah fokus sekarang.',
  ProjectStatus.archived => 'Tidak tampil di daftar utama.',
};

({Color soft, Color strong}) _statusPalette(ProjectStatus status) =>
    switch (status) {
      ProjectStatus.focus => (
        soft: AppColors.actionSoft,
        strong: AppColors.actionDeep,
      ),
      ProjectStatus.maintenance => (
        soft: AppColors.maintenanceSoft,
        strong: AppColors.maintenance,
      ),
      ProjectStatus.parkingLot => (
        soft: AppColors.parkingSoft,
        strong: AppColors.parking,
      ),
      ProjectStatus.archived => (
        soft: AppColors.surfaceSecondary,
        strong: AppColors.textSecondary,
      ),
    };

class _EditLoadError extends StatelessWidget {
  const _EditLoadError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.generous),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppNotice(
            icon: Icons.sync_problem_rounded,
            title: 'Proyek belum dapat dimuat',
            description: 'Data lokal tetap aman. Coba muat lagi.',
            background: AppColors.dangerSoft,
            foreground: AppColors.danger,
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Muat lagi'),
          ),
        ],
      ),
    );
  }
}
