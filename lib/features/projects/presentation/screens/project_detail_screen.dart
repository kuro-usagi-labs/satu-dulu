import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen({required this.projectId, super.key});

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
        title: const Text('Detail proyek'),
      ),
      body: project.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) =>
            const Center(child: Text('Proyek belum dapat dimuat.')),
        data: (value) => value == null
            ? const Center(child: Text('Proyek tidak ditemukan.'))
            : _ProjectContent(project: value),
      ),
    );
  }
}

class _ProjectContent extends ConsumerWidget {
  const _ProjectContent({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusChip(status: project.status),
                  const SizedBox(height: AppSpacing.innerCompact),
                  Text(
                    project.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            IconButton.filledTonal(
              onPressed: () => context.push('/projects/${project.id}/edit'),
              tooltip: 'Edit proyek',
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        _DetailCard(label: 'Tujuan', value: project.shortGoal),
        if (project.whyChosen?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.innerCompact),
          _DetailCard(label: 'Kenapa dipilih', value: project.whyChosen!),
        ],
        if (project.successDefinition?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.innerCompact),
          _DetailCard(
            label: 'Definisi berhasil',
            value: project.successDefinition!,
          ),
        ],
        if (project.reviewDate != null) ...[
          const SizedBox(height: AppSpacing.innerCompact),
          _DetailCard(
            label: 'Review berikutnya',
            value: DateFormat(
              'd MMMM y',
              'id',
            ).format(project.reviewDate!.toLocal()),
          ),
        ],
        const SizedBox(height: AppSpacing.section),
        OutlinedButton.icon(
          onPressed: () => _archive(context, ref),
          icon: const Icon(Icons.archive_outlined),
          label: const Text('Arsipkan proyek'),
        ),
      ],
    );
  }

  Future<void> _archive(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Arsipkan proyek?'),
        content: Text(
          '“${project.name}” tidak lagi tampil di daftar utama. Data hasil tetap disimpan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Arsipkan'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(trackerRepositoryProvider).archiveProject(project.id);
      ref.invalidate(projectsProvider);
      ref.invalidate(todayProvider);
      if (context.mounted) context.go('/projects');
    } on AppException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    }
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      ProjectStatus.focus => 'Focus',
      ProjectStatus.maintenance => 'Maintenance',
      ProjectStatus.parkingLot => 'Parking Lot',
      ProjectStatus.archived => 'Archived',
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.innerCompact,
          vertical: AppSpacing.micro,
        ),
        child: Text(label, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}
