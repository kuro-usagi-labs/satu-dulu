import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';

class RestartCapsuleScreen extends ConsumerStatefulWidget {
  const RestartCapsuleScreen({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<RestartCapsuleScreen> createState() =>
      _RestartCapsuleScreenState();
}

class _RestartCapsuleScreenState extends ConsumerState<RestartCapsuleScreen> {
  final _state = TextEditingController();
  final _output = TextEditingController();
  final _worked = TextEditingController();
  final _blocker = TextEditingController();
  final _next = TextEditingController();
  final _reason = TextEditingController();
  bool _loaded = false;
  bool _saving = false;

  @override
  void dispose() {
    for (final controller in [
      _state,
      _output,
      _worked,
      _blocker,
      _next,
      _reason,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final capsule = ref.watch(restartCapsuleProvider(widget.projectId));
    capsule.whenData(_loadOnce);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Restart Capsule'),
      ),
      body: capsule.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.generous),
          child: Column(
            children: [
              AppLoadingBlock(height: 150),
              SizedBox(height: AppSpacing.standard),
              AppLoadingBlock(height: 280),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: OutlinedButton.icon(
            onPressed: () =>
                ref.invalidate(restartCapsuleProvider(widget.projectId)),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Muat lagi'),
          ),
        ),
        data: (_) => ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.generous,
            AppSpacing.standard,
            AppSpacing.generous,
            AppSpacing.screen,
          ),
          children: [
            const AppEyebrow('Konteks untuk dirimu di masa depan'),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Lanjutkan tanpa mengingat semuanya.',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Isi singkat. Capsule ini muncul saat proyek dilanjutkan atau ketika kamu kehilangan arah.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            const AppNotice(
              icon: Icons.inventory_2_outlined,
              title: 'Bukan backlog baru',
              description:
                  'Simpan hanya konteks yang membantu mulai lagi: kondisi terakhir, hambatan, dan satu tindakan berikutnya.',
            ),
            const SizedBox(height: AppSpacing.major),
            _field(
              controller: _state,
              label: 'Terakhir proyek ini ada di mana?',
              hint:
                  'Contoh: landing page sudah jadi, belum memilih produk pertama',
            ),
            _field(
              controller: _output,
              label: 'Hasil terakhir',
              hint: 'Contoh: 3 video sudah terbit',
            ),
            _field(
              controller: _worked,
              label: 'Apa yang bekerja?',
              hint: 'Contoh: rekam pagi sebelum kerja',
            ),
            _field(
              controller: _blocker,
              label: 'Hambatan terakhir',
              hint: 'Contoh: terlalu lama memilih angle',
            ),
            _field(
              controller: _next,
              label: 'Tindakan pertama saat dilanjutkan',
              hint: 'Contoh: tulis 3 hook untuk produk utama',
              emphasized: true,
            ),
            _field(
              controller: _reason,
              label: 'Kenapa proyek ini sempat diparkir?',
              hint: 'Opsional',
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomActionBar(
        child: FilledButton.icon(
          onPressed: _saving ? null : _save,
          icon: _saving
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.textInverse,
                  ),
                )
              : const Icon(Icons.save_outlined),
          label: Text(_saving ? 'Menyimpan…' : 'Simpan capsule'),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool emphasized = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.innerCompact),
      child: TextField(
        controller: controller,
        minLines: 2,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          alignLabelWithHint: true,
          prefixIcon: emphasized
              ? const Icon(Icons.arrow_forward_rounded)
              : null,
        ),
      ),
    );
  }

  void _loadOnce(RestartCapsule? value) {
    if (_loaded) return;
    _loaded = true;
    _state.text = value?.lastKnownState ?? '';
    _output.text = value?.lastOutput ?? '';
    _worked.text = value?.whatWorked ?? '';
    _blocker.text = value?.blocker ?? '';
    _next.text = value?.nextAction ?? '';
    _reason.text = value?.parkedReason ?? '';
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(antiForgetRepositoryProvider)
          .saveRestartCapsule(
            RestartCapsuleInput(
              projectId: widget.projectId,
              lastKnownState: _state.text,
              lastOutput: _output.text,
              whatWorked: _worked.text,
              blocker: _blocker.text,
              nextAction: _next.text,
              parkedReason: _reason.text,
            ),
          );
      ref.invalidate(restartCapsuleProvider(widget.projectId));
      ref.invalidate(antiForgetTodaySupportProvider);
      if (mounted) context.pop();
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
