import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/guides/presentation/widgets/guide_import_widgets.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class GuideImportScreen extends ConsumerStatefulWidget {
  const GuideImportScreen({required this.staged, super.key});

  final StagedGuideFile staged;

  @override
  ConsumerState<GuideImportScreen> createState() => _GuideImportScreenState();
}

class _GuideImportScreenState extends ConsumerState<GuideImportScreen> {
  static const categories = [
    'Strategi',
    'Kalender',
    'Tutorial',
    'Skrip',
    'Riset',
    'Evaluasi',
    'Produk',
    'Referensi',
    'Lainnya',
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  final _descriptionController = TextEditingController();
  final _whenController = TextEditingController();
  String _category = categories.first;
  String _projectId = '';
  bool _pinned = false;
  bool _saving = false;
  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    final name = widget.staged.originalFileName;
    _titleController = TextEditingController(
      text: name.toLowerCase().endsWith('.pdf')
          ? name.substring(0, name.length - 4)
          : name,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _whenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectsProvider);
    final projects = projectState.value ?? const [];
    final fileDetails =
        '${_formatBytes(widget.staged.fileSizeBytes)} • '
        '${widget.staged.pageCount} halaman';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _cancel();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _saving ? null : _cancel,
            tooltip: 'Batalkan impor',
            icon: const Icon(Icons.close_rounded),
          ),
          title: const Text('Siapkan panduan'),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.generous,
              AppSpacing.compact,
              AppSpacing.generous,
              AppSpacing.major,
            ),
            children: [
              const AppEyebrow('PDF sudah siap', color: AppColors.guide),
              const SizedBox(height: AppSpacing.compact),
              Text(
                'Beri konteks agar mudah ditemukan kembali.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.compact),
              Text(
                'Judul yang jelas dan petunjuk kapan membaca akan membuat PDF ini berguna saat kamu kehilangan arah.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.section),
              GuideStagedFileSummary(
                fileName: widget.staged.originalFileName,
                details: fileDetails,
              ),
              const SizedBox(height: AppSpacing.major),
              const AppSectionHeader(
                title: 'Mudah dikenali',
                description:
                    'Gunakan nama yang masuk akal ketika dilihat nanti',
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Judul panduan',
                  hintText: 'Contoh: Checklist sebelum menerbitkan',
                  helperText: 'Nama file asli tidak akan berubah.',
                  helperMaxLines: 2,
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Judul wajib diisi.'
                    : null,
              ),
              const SizedBox(height: AppSpacing.major),
              const AppSectionHeader(
                title: 'Tempatkan dalam konteks',
                description:
                    'Proyek dan kategori membantu menemukan panduan yang tepat',
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              DropdownButtonFormField<String>(
                initialValue: _projectId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Proyek terkait (opsional)',
                ),
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Tanpa proyek'),
                  ),
                  for (final project in projects)
                    DropdownMenuItem(
                      value: project.id,
                      child: Text(
                        project.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: _saving
                    ? null
                    : (value) => setState(() => _projectId = value ?? ''),
              ),
              const SizedBox(height: AppSpacing.compact),
              GuideImportProjectAvailability(
                loading: projectState.isLoading,
                hasError: projectState.hasError,
                isEmpty: projectState.hasValue && projects.isEmpty,
                onRetry: () => ref.invalidate(projectsProvider),
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              DropdownButtonFormField<String>(
                initialValue: _category,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: [
                  for (final category in categories)
                    DropdownMenuItem(value: category, child: Text(category)),
                ],
                onChanged: _saving
                    ? null
                    : (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: AppSpacing.major),
              const AppSectionHeader(
                title: 'Beri petunjuk untuk dirimu nanti',
                description:
                    'Tulis secukupnya agar kamu tahu alasan membuka dokumen ini',
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              TextFormField(
                controller: _whenController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Buka panduan ini ketika…',
                  hintText: 'Contoh: bingung menentukan topik berikutnya',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              TextFormField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Catatan singkat (opsional)',
                  hintText: 'Apa isi atau manfaat utama dokumen ini?',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: AppSpacing.standard),
              GuideImportPinPreference(
                value: _pinned,
                enabled: !_saving,
                onChanged: (value) => setState(() => _pinned = value),
              ),
              const SizedBox(height: AppSpacing.section),
              const AppNotice(
                icon: Icons.offline_pin_outlined,
                title: 'Tersedia tanpa internet',
                description:
                    'PDF disalin ke penyimpanan aplikasi. Memindahkan file sumber tidak menghapus salinan ini.',
                background: AppColors.guideSoft,
                foreground: AppColors.guide,
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomActionBar(
          child: FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textTertiary,
                    ),
                  )
                : const Text('Simpan sebagai panduan'),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(guideImportCoordinatorProvider)
          .save(
            widget.staged,
            GuideMetadataInput(
              displayTitle: _titleController.text,
              projectId: _projectId.isEmpty ? null : _projectId,
              category: _category,
              description: _descriptionController.text,
              whenToRead: _whenController.text,
              isPinned: _pinned,
            ),
          );
      ref.invalidate(guideDocumentsProvider);
      _leaving = true;
      if (mounted) context.go('/guides/${widget.staged.id}');
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

  Future<void> _cancel() async {
    if (_leaving) return;
    _leaving = true;
    try {
      await ref.read(guideImportCoordinatorProvider).discard(widget.staged);
    } catch (_) {
      // A later orphan cleanup can remove the staged file.
    }
    if (mounted) context.go('/guides');
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
