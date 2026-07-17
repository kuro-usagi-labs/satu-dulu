import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/guides/presentation/widgets/guide_edit_widgets.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class GuideEditScreen extends ConsumerWidget {
  const GuideEditScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final document = ref.watch(guideDocumentProvider(documentId));
    return document.when(
      loading: () => const GuideEditStateScaffold.loading(),
      error: (error, stackTrace) => GuideEditStateScaffold.message(
        title: 'Panduan belum dapat dimuat',
        description:
            'Konteks panduan belum dapat dibuka. Dokumenmu tetap tersimpan.',
        actionLabel: 'Muat kembali',
        onAction: () => ref.invalidate(guideDocumentProvider(documentId)),
      ),
      data: (value) => value == null
          ? GuideEditStateScaffold.message(
              title: 'Panduan tidak ditemukan',
              description:
                  'Dokumen ini mungkin sudah dihapus dari pustaka perangkat.',
              actionLabel: 'Kembali ke pustaka',
              onAction: () => context.go('/guides'),
            )
          : _GuideEditForm(document: value),
    );
  }
}

class _GuideEditForm extends ConsumerStatefulWidget {
  const _GuideEditForm({required this.document});

  final GuideDocument document;

  @override
  ConsumerState<_GuideEditForm> createState() => _GuideEditFormState();
}

class _GuideEditFormState extends ConsumerState<_GuideEditForm> {
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
  late final TextEditingController _descriptionController;
  late final TextEditingController _whenController;
  late String _category;
  late String _projectId;
  late bool _pinned;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.document.displayTitle,
    );
    _descriptionController = TextEditingController(
      text: widget.document.description,
    );
    _whenController = TextEditingController(text: widget.document.whenToRead);
    _category = widget.document.category;
    _projectId = widget.document.projectId ?? '';
    _pinned = widget.document.isPinned;
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
    final currentProjectIncluded =
        _projectId.isEmpty ||
        projects.any((project) => project.id == _projectId);
    final categoryOptions = categories.contains(_category)
        ? categories
        : [_category, ...categories];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _saving ? null : context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Edit panduan'),
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
            const AppEyebrow('Konteks panduan', color: AppColors.guide),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Pastikan panduan ini mudah dikenali saat dibutuhkan.',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Perbarui judul, hubungan proyek, atau petunjuk membaca tanpa mengubah file PDF aslinya.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            GuideOriginalFileNotice(fileName: widget.document.originalFileName),
            const SizedBox(height: AppSpacing.major),
            const AppSectionHeader(
              title: 'Identitas panduan',
              description: 'Nama dan kategori yang mudah dipindai',
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            TextFormField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Judul panduan',
                hintText: 'Judul yang mudah dikenali',
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Judul wajib diisi.'
                  : null,
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            DropdownButtonFormField<String>(
              initialValue: _category,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Kategori'),
              items: [
                for (final category in categoryOptions)
                  DropdownMenuItem(value: category, child: Text(category)),
              ],
              onChanged: _saving
                  ? null
                  : (value) => setState(() => _category = value!),
            ),
            const SizedBox(height: AppSpacing.major),
            const AppSectionHeader(
              title: 'Hubungkan ke arah kerja',
              description:
                  'Proyek terkait membuat panduan muncul dalam konteks yang tepat',
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            DropdownButtonFormField<String>(
              initialValue: _projectId,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Proyek terkait (opsional)',
              ),
              items: [
                const DropdownMenuItem(value: '', child: Text('Tanpa proyek')),
                if (!currentProjectIncluded && _projectId.isNotEmpty)
                  DropdownMenuItem(
                    value: _projectId,
                    child: Text(
                      widget.document.projectName ?? 'Proyek terkait',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
            GuideEditProjectAvailability(
              loading: projectState.isLoading,
              hasError: projectState.hasError,
              isEmpty: projectState.hasValue && projects.isEmpty,
              onRetry: () => ref.invalidate(projectsProvider),
            ),
            const SizedBox(height: AppSpacing.major),
            const AppSectionHeader(
              title: 'Petunjuk pemulihan',
              description:
                  'Tuliskan kapan dan mengapa panduan ini perlu dibuka',
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
                hintText: 'Situasi yang menandakan kamu perlu panduan ini',
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
                hintText: 'Ringkas isi atau manfaat dokumen',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: AppSpacing.standard),
            GuideEditPinPreference(
              value: _pinned,
              enabled: !_saving,
              onChanged: (value) => setState(() => _pinned = value),
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
              : const Text('Simpan perubahan'),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(guideRepositoryProvider)
          .updateMetadata(
            widget.document.id,
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
      ref.invalidate(guideDocumentProvider(widget.document.id));
      if (mounted) context.go('/guides/${widget.document.id}');
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
}
