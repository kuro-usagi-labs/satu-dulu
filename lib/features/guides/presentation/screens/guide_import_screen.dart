import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
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
    final projects = ref.watch(projectsProvider).value ?? const [];
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _cancel();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _saving ? null : _cancel,
            tooltip: 'Batalkan import',
            icon: const Icon(Icons.close_rounded),
          ),
          title: const Text('Detail panduan'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.generous),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.standard),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.picture_as_pdf_outlined,
                        color: AppColors.guide,
                        size: 38,
                      ),
                      const SizedBox(width: AppSpacing.innerCompact),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.staged.originalFileName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.micro),
                            Text(
                              '${_formatBytes(widget.staged.fileSizeBytes)} • ${widget.staged.pageCount} halaman',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.standard),
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
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Tanpa proyek'),
                  ),
                  for (final project in projects)
                    DropdownMenuItem(
                      value: project.id,
                      child: Text(
                        project.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                decoration: const InputDecoration(
                  labelText: 'Deskripsi (opsional)',
                ),
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              TextFormField(
                controller: _whenController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Kapan perlu dibaca? (opsional)',
                ),
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
                    : const Text('Simpan panduan'),
              ),
            ],
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
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
