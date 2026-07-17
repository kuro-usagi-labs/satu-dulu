import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/settings/application/local_backup_coordinator.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';
import 'package:satu_dulu/features/settings/presentation/controllers/settings_providers.dart';

class LocalBackupSection extends ConsumerStatefulWidget {
  const LocalBackupSection({super.key});

  @override
  ConsumerState<LocalBackupSection> createState() => _LocalBackupSectionState();
}

class _LocalBackupSectionState extends ConsumerState<LocalBackupSection> {
  _BackupActivity? _activity;
  _BackupMessage? _message;

  bool get _busy => _activity != null;

  @override
  Widget build(BuildContext context) {
    final coordinator = ref.watch(localBackupCoordinatorProvider);
    final supported = coordinator.isSupported;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(
          title: 'Backup lokal',
          description:
              'Simpan satu salinan lengkap sebelum mengganti perangkat atau bereksperimen besar.',
        ),
        const SizedBox(height: AppSpacing.standard),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.standard),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppIconBadge(
                      icon: Icons.inventory_2_outlined,
                      foreground: AppColors.guide,
                      background: AppColors.guideSoft,
                      size: 44,
                    ),
                    const SizedBox(width: AppSpacing.innerCompact),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Satu file, seluruh arahmu',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.micro),
                          Text(
                            'Mencakup proyek, jadwal, Ship, hasil, pengingat, catatan, dan semua PDF.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.standard),
                const Wrap(
                  spacing: AppSpacing.compact,
                  runSpacing: AppSpacing.compact,
                  children: [
                    AppStatusPill(
                      label: 'ZIP ke Files',
                      tone: AppStatusTone.guide,
                      icon: Icons.folder_outlined,
                    ),
                    AppStatusPill(
                      label: 'Tidak diunggah',
                      tone: AppStatusTone.success,
                      icon: Icons.cloud_off_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.standard),
                FilledButton.icon(
                  key: const Key('create-local-backup'),
                  onPressed: !supported || _busy
                      ? null
                      : () => _create(coordinator),
                  icon: _activity == _BackupActivity.creating
                      ? _progressIcon()
                      : const Icon(Icons.backup_outlined),
                  label: Text(
                    _activity == _BackupActivity.creating
                        ? 'Menyiapkan backup…'
                        : 'Buat backup sekarang',
                  ),
                ),
                const SizedBox(height: AppSpacing.compact),
                OutlinedButton.icon(
                  key: const Key('restore-local-backup'),
                  onPressed: !supported || _busy
                      ? null
                      : () => _inspectAndRestore(coordinator),
                  icon:
                      _activity == _BackupActivity.inspecting ||
                          _activity == _BackupActivity.restoring
                      ? _progressIcon()
                      : const Icon(Icons.settings_backup_restore_rounded),
                  label: Text(switch (_activity) {
                    _BackupActivity.inspecting => 'Memeriksa backup…',
                    _BackupActivity.restoring => 'Memulihkan data…',
                    _ => 'Pulihkan dari backup',
                  }),
                ),
                const SizedBox(height: AppSpacing.compact),
                Text(
                  supported
                      ? 'Restore mengganti data saat ini dan selalu meminta konfirmasi. Backup memakai data yang sudah tersimpan.'
                      : 'Operasi file tersedia di build iOS. Preview web hanya menampilkan alurnya.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_message case final message?) ...[
          const SizedBox(height: AppSpacing.standard),
          AppNotice(
            icon: message.error
                ? Icons.error_outline_rounded
                : Icons.check_circle_outline_rounded,
            title: message.title,
            description: message.description,
            background: message.error
                ? AppColors.dangerSoft
                : AppColors.successSoft,
            foreground: message.error ? AppColors.danger : AppColors.success,
          ),
        ],
      ],
    );
  }

  Widget _progressIcon() {
    return const SizedBox.square(
      dimension: 18,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }

  Future<void> _create(LocalBackupActions coordinator) async {
    setState(() {
      _activity = _BackupActivity.creating;
      _message = null;
    });
    try {
      final result = await coordinator.createBackup();
      if (!mounted || result == null) return;
      setState(() {
        _message = _BackupMessage(
          title: 'Backup tersimpan',
          description:
              '${result.manifest.projectCount} proyek dan ${result.manifest.pdfCount} PDF disimpan sebagai ${result.fileName}.',
        );
      });
    } catch (error) {
      if (mounted) _showError(error);
    } finally {
      if (mounted) setState(() => _activity = null);
    }
  }

  Future<void> _inspectAndRestore(LocalBackupActions coordinator) async {
    setState(() {
      _activity = _BackupActivity.inspecting;
      _message = null;
    });
    try {
      final backup = await coordinator.inspectBackup();
      if (!mounted || backup == null) return;
      setState(() => _activity = null);
      final confirmed = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => _RestoreConfirmationDialog(backup: backup),
      );
      if (confirmed != true || !mounted) return;
      setState(() => _activity = _BackupActivity.restoring);
      final result = await coordinator.restoreBackup(backup);
      if (!mounted) return;
      setState(() {
        _message = _BackupMessage(
          title: 'Data berhasil dipulihkan',
          description:
              result.warning ??
              'Proyek, hasil, pengingat, dan PDF kini mengikuti backup yang dipilih.',
        );
      });
    } catch (error) {
      if (mounted) _showError(error);
    } finally {
      if (mounted) setState(() => _activity = null);
    }
  }

  void _showError(Object error) {
    setState(() {
      _message = _BackupMessage(
        title: 'Backup belum selesai',
        description: error is AppException
            ? error.message
            : 'Terjadi masalah lokal. Data yang sudah tersimpan tidak diubah.',
        error: true,
      );
    });
  }
}

class _RestoreConfirmationDialog extends StatelessWidget {
  const _RestoreConfirmationDialog({required this.backup});

  final PreparedLocalBackup backup;

  @override
  Widget build(BuildContext context) {
    final manifest = backup.manifest;
    return AlertDialog(
      icon: const Icon(Icons.settings_backup_restore_rounded),
      title: const Text('Pulihkan backup ini?'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              backup.sourceName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.micro),
            Text(
              'Dibuat ${_formatDate(manifest.createdAt.toLocal())}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.standard),
            Wrap(
              spacing: AppSpacing.compact,
              runSpacing: AppSpacing.compact,
              children: [
                AppStatusPill(
                  label: '${manifest.projectCount} proyek',
                  tone: AppStatusTone.focus,
                ),
                AppStatusPill(
                  label: '${manifest.pdfCount} PDF',
                  tone: AppStatusTone.guide,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.standard),
            const AppNotice(
              icon: Icons.warning_amber_rounded,
              title: 'Data saat ini akan diganti',
              description:
                  'Buat backup terbaru dulu bila masih ada data sekarang yang ingin disimpan.',
              background: AppColors.warningSoft,
              foreground: AppColors.warning,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Batal'),
        ),
        FilledButton(
          key: const Key('confirm-local-restore'),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Ganti data sekarang'),
        ),
      ],
    );
  }

  static String _formatDate(DateTime value) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    String two(int number) => number.toString().padLeft(2, '0');
    return '${value.day} ${months[value.month - 1]} ${value.year}, '
        '${two(value.hour)}.${two(value.minute)}';
  }
}

enum _BackupActivity { creating, inspecting, restoring }

class _BackupMessage {
  const _BackupMessage({
    required this.title,
    required this.description,
    this.error = false,
  });

  final String title;
  final String description;
  final bool error;
}
