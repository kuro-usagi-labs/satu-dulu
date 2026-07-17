import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class IdeaInboxScreen extends ConsumerWidget {
  const IdeaInboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideas = ref.watch(activeIdeasProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Idea Inbox'),
      ),
      body: SafeArea(
        top: false,
        child: ideas.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.generous),
            child: Column(
              children: [
                AppLoadingBlock(height: 110),
                SizedBox(height: AppSpacing.standard),
                AppLoadingBlock(height: 110),
              ],
            ),
          ),
          error: (error, stackTrace) =>
              _ErrorState(onRetry: () => ref.invalidate(activeIdeasProvider)),
          data: (items) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.generous,
              AppSpacing.standard,
              AppSpacing.generous,
              AppSpacing.screen,
            ),
            children: [
              const AppEyebrow('Tangkap, jangan langsung dikerjakan'),
              const SizedBox(height: AppSpacing.compact),
              Text(
                'Ide aman tanpa mengambil fokus.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.compact),
              Text(
                'Simpan lintasan pikiranmu di sini. Ide baru tidak membuat sprint, tugas, atau tekanan baru.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.major),
              if (items.isEmpty)
                EmptyStateCard(
                  icon: Icons.lightbulb_outline_rounded,
                  title: 'Kepalamu boleh tenang',
                  description:
                      'Belum ada ide yang menunggu. Saat sesuatu muncul, tangkap dengan satu kalimat.',
                  actionLabel: 'Tangkap ide',
                  onAction: () => _editIdea(context, ref),
                )
              else ...[
                AppSectionHeader(
                  title: 'Belum diputuskan',
                  description:
                      'Ubah menjadi proyek hanya saat kamu siap memberi tempatnya.',
                  trailing: Text(
                    '${items.length}',
                    style: AppTextStyles.number.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.standard),
                for (final idea in items) ...[
                  _IdeaCard(
                    idea: idea,
                    onEdit: () => _editIdea(context, ref, idea: idea),
                    onConvert: () => _convert(context, ref, idea),
                    onDisposition: (value) =>
                        _setDisposition(context, ref, idea, value),
                  ),
                  if (idea != items.last)
                    const SizedBox(height: AppSpacing.compact),
                ],
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomActionBar(
        child: FilledButton.icon(
          onPressed: () => _editIdea(context, ref),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Tangkap ide'),
        ),
      ),
    );
  }

  Future<void> _editIdea(
    BuildContext context,
    WidgetRef ref, {
    Idea? idea,
  }) async {
    final title = TextEditingController(text: idea?.title);
    final note = TextEditingController(text: idea?.note);
    final source = TextEditingController(text: idea?.source);
    final result = await showDialog<IdeaInput>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.lightbulb_outline_rounded),
        title: Text(idea == null ? 'Tangkap ide' : 'Rapikan ide'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Judul singkat',
                  hintText: 'Contoh: seri video hair styling',
                ),
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              TextField(
                controller: note,
                minLines: 2,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Catatan (opsional)',
                ),
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              TextField(
                controller: source,
                decoration: const InputDecoration(
                  labelText: 'Muncul dari mana? (opsional)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              IdeaInput(
                title: title.text,
                note: note.text,
                source: source.text,
              ),
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    title.dispose();
    note.dispose();
    source.dispose();
    if (result == null) return;
    try {
      final repository = ref.read(antiForgetRepositoryProvider);
      if (idea == null) {
        await repository.captureIdea(result);
      } else {
        await repository.updateIdea(idea.id, result);
      }
      ref.invalidate(activeIdeasProvider);
    } on AppException catch (error) {
      if (context.mounted) _showError(context, error.message);
    }
  }

  Future<void> _convert(BuildContext context, WidgetRef ref, Idea idea) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.folder_open_rounded),
        title: const Text('Ubah menjadi proyek tersimpan?'),
        content: Text(
          '“${idea.title}” masuk ke Disimpan dulu. Ia belum menjadi fokus dan belum membuat sprint aktif.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Buat proyek'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      final projectId = await ref
          .read(antiForgetRepositoryProvider)
          .convertIdeaToProject(idea.id);
      ref.invalidate(activeIdeasProvider);
      ref.invalidate(projectsProvider);
      if (context.mounted) context.push('/projects/$projectId');
    } on AppException catch (error) {
      if (context.mounted) _showError(context, error.message);
    }
  }

  Future<void> _setDisposition(
    BuildContext context,
    WidgetRef ref,
    Idea idea,
    IdeaDisposition disposition,
  ) async {
    if (disposition == IdeaDisposition.discarded) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Buang ide ini?'),
          content: Text('“${idea.title}” tidak lagi tampil di inbox.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Buang'),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    try {
      await ref
          .read(antiForgetRepositoryProvider)
          .setIdeaDisposition(idea.id, disposition);
      ref.invalidate(activeIdeasProvider);
    } on AppException catch (error) {
      if (context.mounted) _showError(context, error.message);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _IdeaCard extends StatelessWidget {
  const _IdeaCard({
    required this.idea,
    required this.onEdit,
    required this.onConvert,
    required this.onDisposition,
  });

  final Idea idea;
  final VoidCallback onEdit;
  final VoidCallback onConvert;
  final ValueChanged<IdeaDisposition> onDisposition;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('d MMM', 'id_ID').format(idea.capturedAt.toLocal());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppIconBadge(
              icon: idea.disposition == IdeaDisposition.parked
                  ? Icons.bookmark_border_rounded
                  : Icons.lightbulb_outline_rounded,
              foreground: AppColors.accentDeep,
              background: AppColors.accentSoft,
            ),
            const SizedBox(width: AppSpacing.innerCompact),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idea.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (idea.note case final note?) ...[
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      note,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.compact),
                  Text(
                    idea.disposition == IdeaDisposition.parked
                        ? 'Disimpan · $date'
                        : 'Ditangkap $date',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Tindakan ide',
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                  return;
                }
                if (value == 'convert') {
                  onConvert();
                  return;
                }
                if (value == 'park') {
                  onDisposition(IdeaDisposition.parked);
                  return;
                }
                if (value == 'inbox') {
                  onDisposition(IdeaDisposition.inbox);
                  return;
                }
                if (value == 'discard') {
                  onDisposition(IdeaDisposition.discarded);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(
                  value: 'convert',
                  child: Text('Ubah menjadi proyek'),
                ),
                PopupMenuItem(
                  value: idea.disposition == IdeaDisposition.parked
                      ? 'inbox'
                      : 'park',
                  child: Text(
                    idea.disposition == IdeaDisposition.parked
                        ? 'Kembalikan ke inbox'
                        : 'Simpan untuk nanti',
                  ),
                ),
                const PopupMenuItem(value: 'discard', child: Text('Buang')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.generous),
        child: EmptyStateCard(
          icon: Icons.sync_problem_rounded,
          title: 'Idea Inbox belum dapat dibuka',
          description: 'Data lokal tetap aman. Coba muat lagi.',
          actionLabel: 'Muat lagi',
          onAction: onRetry,
        ),
      ),
    );
  }
}
