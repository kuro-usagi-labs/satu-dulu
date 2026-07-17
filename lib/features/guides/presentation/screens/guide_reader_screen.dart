import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/guides/presentation/widgets/guide_reader_states.dart';

class GuideReaderScreen extends ConsumerWidget {
  const GuideReaderScreen({
    required this.documentId,
    this.initialPage,
    super.key,
  });

  final String documentId;
  final int? initialPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final document = ref.watch(guideDocumentProvider(documentId));
    return document.when(
      loading: () => const GuideReaderLoading(),
      error: (error, stackTrace) =>
          const GuideReaderUnavailable(message: 'Panduan belum dapat dimuat.'),
      data: (value) => value == null
          ? const GuideReaderUnavailable(message: 'Panduan tidak ditemukan.')
          : _ResolvedGuideReader(document: value, initialPage: initialPage),
    );
  }
}

class _ResolvedGuideReader extends ConsumerWidget {
  const _ResolvedGuideReader({required this.document, this.initialPage});

  final GuideDocument document;
  final int? initialPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(guidePathProvider(document.storedRelativePath));
    final exists = ref.watch(guideExistsProvider(document.storedRelativePath));
    if (exists.hasValue && exists.value == false) {
      return const GuideReaderUnavailable(
        message: 'File panduan tidak ditemukan di penyimpanan aplikasi.',
      );
    }
    return path.when(
      loading: () => const GuideReaderLoading(),
      error: (error, stackTrace) => const GuideReaderUnavailable(
        message: 'File panduan belum dapat dibuka.',
      ),
      data: (absolutePath) => _GuideReader(
        document: document,
        absolutePath: absolutePath,
        initialPage: initialPage,
      ),
    );
  }
}

class _GuideReader extends ConsumerStatefulWidget {
  const _GuideReader({
    required this.document,
    required this.absolutePath,
    this.initialPage,
  });

  final GuideDocument document;
  final String absolutePath;
  final int? initialPage;

  @override
  ConsumerState<_GuideReader> createState() => _GuideReaderState();
}

class _GuideReaderState extends ConsumerState<_GuideReader>
    with WidgetsBindingObserver {
  final _viewerController = PdfViewerController();
  Timer? _saveTimer;
  late int _currentPage;
  int? _lastSavedPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentPage = (widget.initialPage ?? widget.document.lastReadPage).clamp(
      1,
      widget.document.pageCount,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _flushPage();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _saveTimer?.cancel();
    _flushPage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarks =
        ref.watch(guideBookmarksProvider(widget.document.id)).value ?? const [];
    final bookmarked = bookmarks.any(
      (bookmark) => bookmark.pageNumber == _currentPage,
    );
    return Scaffold(
      backgroundColor: AppColors.surfaceSecondary,
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Tutup pembaca',
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(
          widget.document.displayTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: _showThumbnails,
            tooltip: 'Lihat semua halaman',
            icon: const Icon(Icons.grid_view_rounded),
          ),
          IconButton(
            onPressed: _toggleBookmark,
            tooltip: bookmarked ? 'Hapus bookmark' : 'Simpan bookmark',
            icon: Icon(
              bookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
            ),
          ),
          IconButton(
            onPressed: _addNote,
            tooltip: 'Tambah catatan',
            icon: const Icon(Icons.note_add_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          PdfViewer.file(
            widget.absolutePath,
            controller: _viewerController,
            initialPageNumber: _currentPage,
            params: PdfViewerParams(
              backgroundColor: AppColors.surfaceSecondary,
              onPageChanged: _onPageChanged,
              loadingBannerBuilder: (context, downloaded, total) =>
                  GuideReaderProgress(
                    value: total == null ? null : downloaded / total,
                  ),
              errorBannerBuilder: (context, error, stackTrace, documentRef) {
                return const GuideReaderErrorCard();
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSpacing.standard,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.standard,
                    vertical: AppSpacing.compact,
                  ),
                  child: Text(
                    '$_currentPage / ${widget.document.pageCount}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPageChanged(int? pageNumber) {
    if (pageNumber == null || pageNumber == _currentPage) return;
    setState(() => _currentPage = pageNumber);
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 500), _flushPage);
  }

  void _flushPage() {
    if (_lastSavedPage == _currentPage) return;
    _lastSavedPage = _currentPage;
    unawaited(
      ref
          .read(guideRepositoryProvider)
          .updateLastPage(widget.document.id, _currentPage),
    );
  }

  Future<void> _toggleBookmark() async {
    await ref
        .read(guideRepositoryProvider)
        .toggleBookmark(widget.document.id, _currentPage);
  }

  Future<void> _showThumbnails() async {
    final selectedPage = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.78,
        child: PdfDocumentViewBuilder.file(
          widget.absolutePath,
          loadingBuilder: (context) => const GuideReaderProgress(),
          errorBuilder: (context, error, stackTrace) =>
              const GuideReaderErrorCard(),
          builder: (context, document) {
            if (document == null) {
              return const GuideReaderProgress();
            }
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.standard,
                0,
                AppSpacing.standard,
                AppSpacing.generous,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.68,
                crossAxisSpacing: AppSpacing.compact,
                mainAxisSpacing: AppSpacing.compact,
              ),
              itemCount: document.pages.length,
              itemBuilder: (context, index) {
                final pageNumber = index + 1;
                final selected = pageNumber == _currentPage;
                return InkWell(
                  onTap: () => Navigator.pop(context, pageNumber),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.small),
                      border: Border.all(
                        color: selected ? AppColors.accent : AppColors.border,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(AppRadius.small - 1),
                            ),
                            child: PdfPageView(
                              document: document,
                              pageNumber: pageNumber,
                              maximumDpi: 90,
                              backgroundColor: AppColors.surfaceSecondary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.micro),
                          child: Text(
                            '$pageNumber',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
    if (selectedPage == null || !mounted) return;
    await _viewerController.goToPage(pageNumber: selectedPage);
  }

  Future<void> _addNote() async {
    final controller = TextEditingController();
    final content = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.generous,
          AppSpacing.section,
          AppSpacing.generous,
          MediaQuery.viewInsetsOf(context).bottom + AppSpacing.generous,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Catatan halaman $_currentPage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.standard),
            TextField(
              controller: controller,
              autofocus: true,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Apa yang perlu kamu ingat?',
              ),
            ),
            const SizedBox(height: AppSpacing.standard),
            FilledButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isNotEmpty) Navigator.pop(context, value);
              },
              child: const Text('Simpan catatan'),
            ),
          ],
        ),
      ),
    );
    controller.dispose();
    if (content == null || !mounted) return;
    await ref
        .read(guideRepositoryProvider)
        .saveNote(widget.document.id, _currentPage, content);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Catatan disimpan.')));
    }
  }
}
