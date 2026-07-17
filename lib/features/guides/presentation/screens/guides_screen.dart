import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/guides/presentation/widgets/guide_library_widgets.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class GuidesScreen extends ConsumerStatefulWidget {
  const GuidesScreen({super.key});

  @override
  ConsumerState<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends ConsumerState<GuidesScreen> {
  late final TextEditingController _searchController;
  Timer? _debounce;
  bool _importing = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(guideSearchQueryProvider),
    );
  }

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
    final hasQuery = _searchController.text.trim().isNotEmpty;

    return ScreenFrame(
      eyebrow: 'Pustaka pemulihan',
      title: strings.guidesTitle,
      subtitle: 'Panduan yang membantumu kembali bergerak.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppNotice(
            icon: Icons.explore_outlined,
            title: 'Bukan sekadar tempat menyimpan PDF',
            description:
                'Hubungkan panduan ke proyek dan tulis kapan dokumen perlu dibuka. Semuanya tetap tersedia offline.',
            background: AppColors.guideSoft,
            foreground: AppColors.guide,
          ),
          const SizedBox(height: AppSpacing.standard),
          FilledButton.icon(
            onPressed: _importing ? null : _import,
            icon: _importing
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textTertiary,
                    ),
                  )
                : const Icon(Icons.file_open_outlined),
            label: Text(_importing ? 'Menyiapkan PDF…' : 'Impor PDF panduan'),
          ),
          const SizedBox(height: AppSpacing.section),
          TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Cari panduan',
              hintText: 'Judul, kategori, atau proyek',
              prefixIcon: const Icon(Icons.search_rounded),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.input),
                ),
                borderSide: BorderSide(color: AppColors.guide, width: 1.5),
              ),
              suffixIcon: hasQuery
                  ? IconButton(
                      onPressed: _clearSearch,
                      tooltip: 'Hapus pencarian',
                      icon: const Icon(Icons.close_rounded),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          documents.when(
            loading: () => const GuideLoadingState(),
            error: (error, stackTrace) => GuideMessagePanel(
              icon: Icons.cloud_off_outlined,
              title: 'Pustaka belum dapat dibuka',
              description:
                  'Dokumenmu tetap aman di perangkat. Coba muat kembali pustaka.',
              actionLabel: 'Muat kembali',
              onAction: () => ref.invalidate(guideDocumentsProvider),
            ),
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
    final query = _searchController.text.trim();
    if (items.isEmpty && query.isEmpty) {
      return EmptyStateCard(
        icon: Icons.auto_stories_outlined,
        title: strings.noGuidesTitle,
        description:
            'Impor satu PDF yang paling sering kamu butuhkan saat bingung harus mulai dari mana.',
        footnote:
            'Gunakan tombol Impor PDF panduan di atas. File disalin ke penyimpanan aplikasi dan dapat dibaca offline.',
      );
    }
    if (items.isEmpty) {
      return GuideMessagePanel(
        icon: Icons.search_off_rounded,
        title: 'Belum menemukan panduan',
        description: 'Tidak ada dokumen yang cocok dengan “$query”.',
        actionLabel: 'Hapus pencarian',
        onAction: _clearSearch,
      );
    }

    if (query.isNotEmpty) {
      return GuideSection(
        title: 'Hasil pencarian',
        description: '${items.length} panduan ditemukan',
        items: items,
      );
    }

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
          GuideSection(
            title: 'Disematkan',
            description: 'Petunjuk yang ingin kamu jangkau lebih cepat',
            items: pinned,
          ),
          const SizedBox(height: AppSpacing.major),
        ],
        if (continuing.isNotEmpty) ...[
          GuideSection(
            title: 'Lanjutkan membaca',
            description: 'Kembali ke halaman terakhir tanpa mencari ulang',
            items: continuing,
          ),
          const SizedBox(height: AppSpacing.major),
        ],
        if (others.isNotEmpty)
          GuideSection(
            title: pinned.isEmpty && continuing.isEmpty
                ? 'Semua panduan'
                : 'Panduan lainnya',
            description: 'Dokumen yang siap dibuka saat dibutuhkan',
            items: others,
          ),
      ],
    );
  }

  void _onSearchChanged(String value) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      ref.read(guideSearchQueryProvider.notifier).setQuery(value);
    });
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    ref.read(guideSearchQueryProvider.notifier).setQuery('');
    setState(() {});
  }

  Future<void> _import() async {
    if (_importing) return;
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
