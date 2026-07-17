import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/projects/presentation/widgets/project_detail_widgets.dart';

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
        title: const Text('Arah proyek'),
        actions: [
          IconButton(
            onPressed: () => context.push('/projects/$projectId/edit'),
            tooltip: 'Edit proyek',
            icon: const Icon(Icons.edit_outlined),
          ),
          const SizedBox(width: AppSpacing.compact),
        ],
      ),
      body: project.when(
        loading: () => const ProjectDetailLoading(),
        error: (error, stackTrace) => ProjectDetailError(
          onRetry: () => ref.invalidate(projectProvider(projectId)),
        ),
        data: (value) => value == null
            ? const ProjectNotFound()
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
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.generous,
        AppSpacing.standard,
        AppSpacing.generous,
        AppSpacing.screen,
      ),
      children: [
        ProjectIdentityCard(project: project),
        const SizedBox(height: AppSpacing.major),
        const AppSectionHeader(
          title: 'Arah yang kamu pilih',
          description: 'Baca bagian ini lagi ketika perhatian mulai pecah.',
        ),
        const SizedBox(height: AppSpacing.standard),
        ProjectDirectionItem(
          number: '01',
          label: 'Tujuan 30 hari',
          value: project.shortGoal,
          emphasized: true,
        ),
        if (project.whyChosen?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.standard),
          ProjectDirectionItem(
            number: '02',
            label: 'Kenapa ini penting sekarang',
            value: project.whyChosen!,
          ),
        ],
        if (project.successDefinition?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.standard),
          ProjectDirectionItem(
            number: '03',
            label: 'Bukti yang ingin dicari',
            value: project.successDefinition!,
          ),
        ],
        const SizedBox(height: AppSpacing.major),
        const AppSectionHeader(
          title: 'Lanjut dari sini',
          description: 'Setiap ruang punya satu tugas yang berbeda.',
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        ProjectDestination(
          icon: Icons.today_rounded,
          title: 'Kerjakan di Hari Ini',
          description: 'Lihat hasil dan langkah konkret berikutnya.',
          emphasized: project.status == ProjectStatus.focus,
          onTap: () => context.go('/today'),
        ),
        const SizedBox(height: AppSpacing.compact),
        ProjectDestination(
          icon: Icons.menu_book_rounded,
          title: 'Buka Panduan',
          description: 'Cari rujukan ketika kamu macet atau lupa arah.',
          onTap: () => context.go('/guides'),
        ),
        const SizedBox(height: AppSpacing.compact),
        ProjectDestination(
          icon: Icons.insights_rounded,
          title: 'Lihat Hasil',
          description: 'Gunakan bukti untuk menentukan langkah berikutnya.',
          onTap: () => context.go('/results'),
        ),
        const SizedBox(height: AppSpacing.major),
        TextButton.icon(
          onPressed: () => _archive(context, ref),
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
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
        icon: const Icon(Icons.archive_outlined),
        title: const Text('Arsipkan proyek?'),
        content: Text(
          '“${project.name}” tidak lagi muncul di daftar utama. Semua hasil dan data tetap disimpan.',
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
