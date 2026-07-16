import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class GuidesScreen extends ConsumerStatefulWidget {
  const GuidesScreen({super.key});

  @override
  ConsumerState<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends ConsumerState<GuidesScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _importing = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final documents = ref.watch(guideDocumentsProvider);

    return ScreenFrame(
      title: strings.guidesTitle,
      subtitle: strings.guidesSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Cari judul, kategori, proyek…',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(
                onPressed: _importing ? null : _import,
                tooltip: 'Tambah PDF',
                icon: _importing
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add_rounded),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          documents.when(
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            error: (error, stackTrace) => const _GuideLoadError(),
            data: (items) => _buildDocuments(context, items, strings),
          ),
        ],
      ),
    );
  }

  Widget _buildDocuments(
    BuildContext context,
    List<GuideDocument> items,
    AppLocalizations strings,
  ) {
    if (items.isEmpty && _searchController.text.trim().isEmpty) {
      return EmptyStateCard(
        icon: Icons.picture_as_pdf_outlined,
        title: strings.noGuidesTitle,
        description: strings.noGuidesDescription,
        actionLabel: strings.addGuide,
        onAction: _import,
      );
    }
    if (items.isEmpty) {
      return const _GuideLoadError(
        message: 'Tidak ada panduan yang cocok dengan pencarian.',
        icon: Icons.search_off_rounded,
      );
    }

    final searching = _searchController.text.trim().isNotEmpty;
    if (searching) return _GuideSection(title: 'Hasil pencarian', items: items);

    final pinned = items.where((item) => item.isPinned).toList();
    final continuing = items
        .where((item) => !item.isPinned && item.lastReadPage > 1)
        .toList();
    final others = items
        .where((item) => !item.isPinned && item.lastReadPage <= 1)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (pinned.isNotEmpty) ...[
          _GuideSection(title: 'Disematkan', items: pinned),
          const SizedBox(height: AppSpacing.section),
        ],
        if (continuing.isNotEmpty) ...[
          _GuideSection(title: 'Lanjutkan membaca', items: continuing),
          const SizedBox(height: AppSpacing.section),
        ],
        if (others.isNotEmpty)
          _GuideSection(title: 'Semua panduan', items: others),
      ],
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      ref.read(guideSearchQueryProvider.notifier).setQuery(value);
    });
  }

  Future<void> _import() async {
    setState(() => _importing = true);
    try {
      final staged = await ref
          .read(guideImportCoordinatorProvider)
          .pickAndStage();
      if (staged != null && mounted) {
        await context.push('/guides/import', extra: staged);
      }
    } on AppException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }
}

class _GuideSection extends StatelessWidget {
  const _GuideSection({required this.title, required this.items});

  final String title;
  final List<GuideDocument> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.innerCompact),
        for (final document in items) ...[
          _GuideCard(document: document),
          if (document != items.last)
            const SizedBox(height: AppSpacing.innerCompact),
        ],
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({required this.document});

  final GuideDocument document;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/guides/${document.id}'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.standard),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.guideSoft,
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: const Icon(
                  Icons.picture_as_pdf_outlined,
                  color: AppColors.guide,
                ),
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            document.displayTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        if (document.isPinned)
                          const Icon(
                            Icons.push_pin_rounded,
                            size: 18,
                            color: AppColors.guide,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      [
                        document.projectName,
                        document.category,
                      ].whereType<String>().join(' • '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.compact),
                    LinearProgressIndicator(
                      value: document.progress.clamp(0, 1),
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(999),
                      backgroundColor: AppColors.surfaceSecondary,
                      color: AppColors.guide,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.compact),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuideLoadError extends StatelessWidget {
  const _GuideLoadError({
    this.message = 'Panduan belum dapat dimuat. Coba buka ulang aplikasi.',
    this.icon = Icons.error_outline_rounded,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.innerCompact),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
