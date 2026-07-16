import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class GuideEditScreen extends ConsumerWidget {
  const GuideEditScreen({required this.documentId, super.key});

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
        title: const Text('Edit panduan'),
      ),
      body: document.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) =>
            const Center(child: Text('Panduan belum dapat dimuat.')),
        data: (value) => value == null
            ? const Center(child: Text('Panduan tidak ditemukan.'))
            : _GuideEditForm(document: value),
      ),
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
    final projects = ref.watch(projectsProvider).value ?? const [];
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.generous),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Judul tampilan'),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Judul wajib diisi.'
                : null,
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          DropdownButtonFormField<String>(
            initialValue: _projectId,
            decoration: const InputDecoration(labelText: 'Proyek'),
            items: [
              const DropdownMenuItem(value: '', child: Text('Tanpa proyek')),
              for (final project in projects)
                DropdownMenuItem(value: project.id, child: Text(project.name)),
            ],
            onChanged: (value) => setState(() => _projectId = value ?? ''),
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          DropdownButtonFormField<String>(
            initialValue: _category,
            decoration: const InputDecoration(labelText: 'Kategori'),
            items: [
              for (final category in categories)
                DropdownMenuItem(value: category, child: Text(category)),
            ],
            onChanged: (value) => setState(() => _category = value!),
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          TextFormField(
            controller: _descriptionController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Deskripsi'),
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          TextFormField(
            controller: _whenController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Kapan perlu dibaca?'),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            value: _pinned,
            onChanged: (value) => setState(() => _pinned = value),
            title: const Text('Sematkan panduan'),
          ),
          const SizedBox(height: AppSpacing.section),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Simpan perubahan'),
          ),
          const SizedBox(height: AppSpacing.compact),
          Text(
            'Nama file fisik tetap ${widget.document.originalFileName}.',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
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
