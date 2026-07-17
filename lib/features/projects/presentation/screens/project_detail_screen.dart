import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';
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
    final capsule = ref.watch(restartCapsuleProvider(project.id));
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
          title: 'Restart Capsule',
          description:
              'Konteks pendek agar kamu bisa kembali tanpa mengingat semuanya.',
        ),
        const SizedBox(height: AppSpacing.standard),
        capsule.when(
          loading: () => const AppLoadingBlock(height: 124),
          error: (error, stackTrace) => OutlinedButton.icon(
            onPressed: () => ref.invalidate(restartCapsuleProvider(project.id)),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Muat capsule lagi'),
          ),
          data: (value) => _RestartCapsuleCard(
            nextAction: value?.nextAction,
            blocker: value?.blocker,
            hasContext: value?.hasContext ?? false,
            onTap: () => context.push('/projects/${project.id}/restart'),
          ),
        ),
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
          '“${project.name}” tidak lagi muncul di daftar utama. Semua hasil, capsule, dan data tetap disimpan.',
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
      ref.invalidate(antiForgetTodaySupportProvider);
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

class _RestartCapsuleCard extends StatelessWidget {
  const _RestartCapsuleCard({
    required this.nextAction,
    required this.blocker,
    required this.hasContext,
    required this.onTap,
  });

  final String? nextAction;
  final String? blocker;
  final bool hasContext;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: hasContext ? AppColors.guideSoft : AppColors.surfaceSecondary,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.standard),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconBadge(
                icon: Icons.inventory_2_outlined,
                foreground: hasContext ? AppColors.guide : AppColors.textSecondary,
                background: AppColors.surface,
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasContext ? 'Konteks tersimpan' : 'Capsule belum diisi',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      nextAction?.trim().isNotEmpty == true
                          ? 'Mulai lagi dari: $nextAction'
                          : blocker?.trim().isNotEmpty == true
                          ? 'Hambatan terakhir: $blocker'
                          : 'Simpan kondisi terakhir, hambatan, dan satu tindakan pertama.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
