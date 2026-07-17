import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/guides/presentation/widgets/guide_detail_widgets.dart';
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
        title: const Text('Panduan'),
      ),
      body: document.when(
        loading: () => const GuideDetailLoadingState(),
        error: (error, stackTrace) => GuideDetailMessageState(
          icon: Icons.menu_book_outlined,
          title: 'Panduan belum dapat dimuat',
          description:
              'Dokumenmu tetap tersimpan. Muat kembali halaman ini untuk mencoba lagi.',
          actionLabel: 'Muat kembali',
          onAction: () => ref.invalidate(guideDocumentProvider(documentId)),
        ),
        data: (value) => value == null
            ? GuideDetailMessageState(
                icon: Icons.find_in_page_outlined,
                title: 'Panduan tidak ditemukan',
                description:
                    'Dokumen ini mungkin sudah dihapus dari pustaka perangkat.',
                actionLabel: 'Kembali ke pustaka',
                onAction: () => context.go('/guides'),
              )
            : _GuideDetail(document: value),
      ),
    );
  }
}

class _GuideDetail extends ConsumerStatefulWidget {
  const _GuideDetail({required this.document});

  final GuideDocument document;

  @override
  ConsumerState<_GuideDetail> createState() => _GuideDetailState();
}

class _GuideDetailState extends ConsumerState<_GuideDetail> {
  bool _settingPrimary = false;
  bool _deleting = false;

  GuideDocument get document => widget.document;

  @override
  Widget build(BuildContext context) {
    final exists = ref.watch(guideExistsProvider(document.storedRelativePath));
    final bookmarks = ref.watch(guideBookmarksProvider(document.id));
    final notes = ref.watch(guideNotesProvider(document.id));
    final linkedProjectState = document.projectId == null
        ? null
        : ref.watch(projectProvider(document.projectId!));
    final linkedProject = linkedProjectState?.value;
    final isPrimary = linkedProject?.primaryGuideDocumentId == document.id;
    final projectReady =
        linkedProjectState == null || linkedProjectState.hasValue;
    final bookmarkLabel = bookmarks.when(
      data: (items) => '${items.length} bookmark',
      loading: () => 'Memuat bookmark…',
      error: (error, stackTrace) => 'Bookmark belum dapat dimuat',
    );
    final noteLabel = notes.when(
      data: (items) => '${items.length} catatan',
      loading: () => 'Memuat catatan…',
      error: (error, stackTrace) => 'Catatan belum dapat dimuat',
    );

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.generous,
        AppSpacing.compact,
        AppSpacing.generous,
        AppSpacing.screen,
      ),
      children: [
        const AppEyebrow('Panduan pemulihan', color: AppColors.guide),
        const SizedBox(height: AppSpacing.compact),
        Text(
          document.displayTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        Wrap(
          spacing: AppSpacing.compact,
          runSpacing: AppSpacing.compact,
          children: [
            GuideMetadataLabel(
              icon: Icons.sell_outlined,
              label: document.category,
            ),
            GuideMetadataLabel(
              icon: Icons.description_outlined,
              label: '${document.pageCount} halaman',
            ),
            if (document.isPinned)
              const GuideMetadataLabel(
                icon: Icons.push_pin_outlined,
                label: 'Disematkan',
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        GuideFileSummary(document: document),
        const SizedBox(height: AppSpacing.section),
        GuideReadingProgress(document: document),
        const SizedBox(height: AppSpacing.standard),
        exists.when(
          loading: () => const FilledButton(
            onPressed: null,
            child: Text('Memeriksa file…'),
          ),
          error: (error, stackTrace) => const GuideMissingFileNotice(),
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
              : const GuideMissingFileNotice(),
        ),
        if (document.whenToRead?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.major),
          GuideRecoveryPrompt(message: document.whenToRead!),
        ],
        if (document.projectId != null) ...[
          const SizedBox(height: AppSpacing.major),
          AppSectionHeader(
            title: 'Terhubung ke proyek',
            description:
                'Hubungan ini membuat panduan lebih mudah ditemukan saat kamu kehilangan arah.',
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          GuideLinkedProjectPanel(
            projectName: document.projectName ?? 'Proyek terkait',
            isPrimary: isPrimary,
            loading: !projectReady || _settingPrimary,
            hasError: linkedProjectState?.hasError ?? false,
            onSetPrimary: isPrimary || !projectReady || _settingPrimary
                ? null
                : _setPrimary,
          ),
        ],
        if (document.description?.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.major),
          const AppSectionHeader(
            title: 'Tentang panduan ini',
            description: 'Konteks singkat sebelum kamu mulai membaca',
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          GuideEditorialPanel(child: Text(document.description!)),
        ],
        const SizedBox(height: AppSpacing.major),
        const AppSectionHeader(
          title: 'Jejak membaca',
          description: 'Bookmark dan catatan disimpan lokal bersama PDF',
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        GuideReadingToolsPanel(
          bookmarkLabel: bookmarkLabel,
          noteLabel: noteLabel,
        ),
        const SizedBox(height: AppSpacing.major),
        OutlinedButton.icon(
          onPressed: () => context.push('/guides/${document.id}/edit'),
          icon: const Icon(Icons.tune_rounded),
          label: const Text('Edit konteks panduan'),
        ),
        const SizedBox(height: AppSpacing.standard),
        TextButton.icon(
          onPressed: _deleting ? null : _delete,
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          icon: _deleting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.delete_outline_rounded),
          label: Text(_deleting ? 'Menghapus…' : 'Hapus panduan'),
        ),
      ],
    );
  }

  Future<void> _setPrimary() async {
    final projectId = document.projectId;
    if (projectId == null || _settingPrimary) return;
    setState(() => _settingPrimary = true);
    try {
      await ref
          .read(guideRepositoryProvider)
          .setPrimaryGuide(projectId, document.id);
      ref.invalidate(projectProvider(projectId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Panduan utama proyek diperbarui.')),
        );
      }
    } on AppException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _settingPrimary = false);
    }
  }

  Future<void> _delete() async {
    if (_deleting) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus panduan?'),
        content: Text(
          '“${document.displayTitle}” akan dihapus dari aplikasi dan tidak dapat dibaca lagi secara offline.',
        ),
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
    if (confirmed != true || !mounted) return;
    setState(() => _deleting = true);
    try {
      await ref.read(guideImportCoordinatorProvider).deleteDocument(document);
      ref.invalidate(guideDocumentsProvider);
      if (mounted) context.go('/guides');
    } on AppException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }
}
