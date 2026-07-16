import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class GuideDetailScreen extends ConsumerWidget {
  const GuideDetailScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final document = ref.watch(guideDocumentProvider(documentId));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Detail panduan'),
      ),
      body: document.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) =>
            const Center(child: Text('Panduan belum dapat dimuat.')),
        data: (value) => value == null
            ? const Center(child: Text('Panduan tidak ditemukan.'))
            : _GuideDetail(document: value),
      ),
    );
  }
}

class _GuideDetail extends ConsumerWidget {
  const _GuideDetail({required this.document});

  final GuideDocument document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exists = ref.watch(guideExistsProvider(document.storedRelativePath));
    final bookmarks =
        ref.watch(guideBookmarksProvider(document.id)).value ?? const [];
    final notes = ref.watch(guideNotesProvider(document.id)).value ?? const [];
    final linkedProject = document.projectId == null
        ? null
        : ref.watch(projectProvider(document.projectId!)).value;
    final isPrimary = linkedProject?.primaryGuideDocumentId == document.id;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 84,
              height: 112,
              decoration: BoxDecoration(
                color: AppColors.guideSoft,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: const Icon(
                Icons.picture_as_pdf_outlined,
                size: 42,
                color: AppColors.guide,
              ),
            ),
            const SizedBox(width: AppSpacing.standard),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.displayTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.compact),
                  Text(
                    document.originalFileName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.compact),
                  Text('${document.pageCount} halaman • ${document.category}'),
                ],
              ),
            ),
            IconButton(
              onPressed: () => context.push('/guides/${document.id}/edit'),
              tooltip: 'Edit metadata',
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        LinearProgressIndicator(
          value: document.progress.clamp(0.0, 1.0),
          minHeight: 6,
          borderRadius: BorderRadius.circular(999),
          color: AppColors.guide,
          backgroundColor: AppColors.surfaceSecondary,
        ),
        const SizedBox(height: AppSpacing.compact),
        Text(
          'Halaman ${document.lastReadPage} dari ${document.pageCount}',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.standard),
        exists.when(
          loading: () => const FilledButton(
            onPressed: null,
            child: Text('Memeriksa file…'),
          ),
          error: (error, stackTrace) => const _MissingFileCard(),
          data: (available) => available
              ? FilledButton.icon(
                  onPressed: () => context.push('/guides/${document.id}/read'),
                  icon: const Icon(Icons.menu_book_rounded),
                  label: Text(
                    document.lastReadPage > 1
                        ? 'Lanjutkan membaca'
                        : 'Buka panduan',
                  ),
                )
              : const _MissingFileCard(),
        ),
        const SizedBox(height: AppSpacing.section),
        if (document.projectName != null)
          _MetadataCard(label: 'Proyek', value: document.projectName!),
        if (document.description?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.innerCompact),
          _MetadataCard(label: 'Deskripsi', value: document.description!),
        ],
        if (document.whenToRead?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.innerCompact),
          _MetadataCard(label: 'Baca ketika', value: document.whenToRead!),
        ],
        const SizedBox(height: AppSpacing.innerCompact),
        _MetadataCard(
          label: 'Catatan dan bookmark',
          value: '${bookmarks.length} bookmark • ${notes.length} catatan',
        ),
        if (document.projectId != null) ...[
          const SizedBox(height: AppSpacing.standard),
          OutlinedButton.icon(
            onPressed: isPrimary
                ? null
                : () => _setPrimary(context, ref, document.projectId!),
            icon: Icon(isPrimary ? Icons.check_rounded : Icons.link_rounded),
            label: Text(
              isPrimary ? 'Panduan utama proyek' : 'Jadikan panduan utama',
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.standard),
        TextButton.icon(
          onPressed: () => _delete(context, ref),
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          icon: const Icon(Icons.delete_outline_rounded),
          label: const Text('Hapus panduan'),
        ),
      ],
    );
  }

  Future<void> _setPrimary(
    BuildContext context,
    WidgetRef ref,
    String projectId,
  ) async {
    await ref
        .read(guideRepositoryProvider)
        .setPrimaryGuide(projectId, document.id);
    ref.invalidate(projectProvider(projectId));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Panduan utama proyek diperbarui.')),
      );
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus panduan?'),
        content: Text('“${document.displayTitle}” akan dihapus dari aplikasi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(guideImportCoordinatorProvider).deleteDocument(document);
      ref.invalidate(guideDocumentsProvider);
      if (context.mounted) context.go('/guides');
    } on AppException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    }
  }
}

class _MetadataCard extends StatelessWidget {
  const _MetadataCard({required this.label, required this.value});

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
            Text(value),
          ],
        ),
      ),
    );
  }
}

class _MissingFileCard extends StatelessWidget {
  const _MissingFileCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: AppColors.dangerSoft,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.standard),
        child: Text('File panduan tidak ditemukan di penyimpanan aplikasi.'),
      ),
    );
  }
}
