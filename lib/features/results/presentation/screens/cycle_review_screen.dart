import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/services/money_units.dart';
import 'package:satu_dulu/features/results/presentation/controllers/cycle_review_controller.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';
import 'package:satu_dulu/features/results/presentation/widgets/cycle_review_widgets.dart';

class CycleReviewScreen extends ConsumerStatefulWidget {
  const CycleReviewScreen({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<CycleReviewScreen> createState() => _CycleReviewScreenState();
}

class _CycleReviewScreenState extends ConsumerState<CycleReviewScreen> {
  final _pivotApproach = TextEditingController();
  final _pivotFocus = FocusNode();
  CycleDecision? _decision;
  String? _replacementProjectId;
  bool _submitting = false;
  bool _showPivotError = false;
  String? _submitError;

  @override
  void dispose() {
    _pivotApproach.dispose();
    _pivotFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localDate = _localDay(DateTime.now());
    final query = (projectId: widget.projectId, localDate: localDate);
    final target = ref.watch(cycleReviewTargetProvider(query));
    final ready = target.asData?.value;
    final sprint = ready?.canClose == true ? ready?.sprint : null;
    final summary = sprint == null
        ? null
        : ref.watch(
            cycleResultsSummaryProvider((
              projectId: widget.projectId,
              startDate: sprint.startDate,
              endDate: sprint.endDate,
            )),
          );
    final canSubmit =
        sprint != null && summary?.asData != null && _decision != null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _leave,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Tutup putaran'),
      ),
      body: target.when(
        loading: () => const _CycleReviewLoading(),
        error: (error, stackTrace) => CycleReviewMessage(
          icon: Icons.sync_problem_outlined,
          title: 'Review belum dapat dimuat',
          description:
              'Data lokalmu tidak berubah. Coba baca ulang putaran ini.',
          actionLabel: 'Muat lagi',
          onAction: () => ref.invalidate(cycleReviewTargetProvider(query)),
          tone: AppStatusTone.warning,
        ),
        data: (value) => _buildTarget(target: value, summary: summary),
      ),
      bottomNavigationBar: sprint == null
          ? null
          : AppBottomActionBar(
              child: SizedBox(
                width: double.infinity,
                child: AppActionButton(
                  label: _submitLabel,
                  icon: _decision == null ? null : Icons.arrow_forward_rounded,
                  isLoading: _submitting,
                  onPressed: canSubmit
                      ? () => _submit(sprint, summary?.asData?.value)
                      : null,
                ),
              ),
            ),
    );
  }

  Widget _buildTarget({
    required CycleReviewTarget? target,
    required AsyncValue<ResultsSummary>? summary,
  }) {
    if (target == null) {
      return CycleReviewMessage(
        icon: Icons.folder_off_outlined,
        title: 'Proyek tidak ditemukan',
        description:
            'Proyek ini mungkin sudah dihapus atau tautannya tidak lagi berlaku.',
        actionLabel: 'Buka Proyek',
        onAction: () => context.go('/projects'),
      );
    }

    final sprint = target.sprint;
    return switch (target.availability) {
      CycleReviewAvailability.due when sprint != null => _buildReady(
        target.project,
        sprint,
        summary!,
      ),
      CycleReviewAvailability.notDue => CycleReviewMessage(
        icon: Icons.calendar_today_outlined,
        title: 'Putaran masih berjalan',
        description: sprint == null
            ? 'Belum ada putaran yang siap ditutup.'
            : 'Kumpulkan bukti sampai ${_date(sprint.endDate)}. Setelah itu, pilih arah berikutnya.',
        actionLabel: 'Kembali ke Hari Ini',
        onAction: () => context.go('/today'),
      ),
      CycleReviewAvailability.closed => CycleReviewMessage(
        icon: Icons.task_alt_rounded,
        title: 'Putaran ini sudah ditutup',
        description:
            'Keputusannya sudah tersimpan. Lihat Hasil untuk membaca bukti proyek.',
        actionLabel: 'Lihat Hasil',
        onAction: () => context.go('/results'),
        tone: AppStatusTone.success,
      ),
      CycleReviewAvailability.unavailable ||
      CycleReviewAvailability.due => CycleReviewMessage(
        icon: Icons.flag_outlined,
        title: 'Belum ada putaran untuk ditutup',
        description:
            'Proyek ini bukan fokus aktif atau belum memiliki putaran yang dapat direview.',
        actionLabel: 'Buka Proyek',
        onAction: () => context.go('/projects/${widget.projectId}'),
      ),
    };
  }

  Widget _buildReady(
    Project project,
    Sprint sprint,
    AsyncValue<ResultsSummary> summary,
  ) {
    final projects = ref.watch(projectsProvider);
    final dateRange = '${_date(sprint.startDate)} – ${_date(sprint.endDate)}';

    return SafeArea(
      bottom: false,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.generous,
          AppSpacing.compact,
          AppSpacing.generous,
          AppSpacing.section,
        ),
        children: [
          const AppEyebrow('PUTARAN 30 HARI'),
          const SizedBox(height: AppSpacing.compact),
          Text(project.name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.micro),
          Text(
            dateRange,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.section),
          summary.when(
            loading: () => const AppLoadingBlock(height: 184),
            error: (error, stackTrace) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppNotice(
                  icon: Icons.insights_outlined,
                  title: 'Snapshot bukti belum terbaca',
                  description:
                      'Keputusan belum dikirim. Muat ulang agar bukti putaran tetap akurat.',
                  background: AppColors.warningSoft,
                  foreground: AppColors.warning,
                ),
                const SizedBox(height: AppSpacing.compact),
                OutlinedButton.icon(
                  onPressed: () => ref.invalidate(
                    cycleResultsSummaryProvider((
                      projectId: widget.projectId,
                      startDate: sprint.startDate,
                      endDate: sprint.endDate,
                    )),
                  ),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Muat bukti lagi'),
                ),
              ],
            ),
            data: (value) => CycleEvidenceSnapshot(summary: value),
          ),
          const SizedBox(height: AppSpacing.section),
          const AppSectionHeader(
            title: 'Pilih arah berikutnya',
            description:
                'Satu keputusan untuk putaran ini. Bukti lama tetap tersimpan.',
          ),
          const SizedBox(height: AppSpacing.standard),
          CycleDecisionCard(
            icon: Icons.arrow_forward_rounded,
            title: 'Lanjutkan',
            description:
                'Tujuan dan pendekatan tetap. Mulai putaran 30 hari baru.',
            selected: _decision == CycleDecision.continueFocus,
            onTap: () => _select(CycleDecision.continueFocus),
          ),
          const SizedBox(height: AppSpacing.compact),
          CycleDecisionCard(
            icon: Icons.alt_route_rounded,
            title: 'Ubah pendekatan',
            description: 'Tujuan tetap; uji cara baru pada putaran berikutnya.',
            selected: _decision == CycleDecision.pivot,
            onTap: () => _select(CycleDecision.pivot),
          ),
          const SizedBox(height: AppSpacing.compact),
          CycleDecisionCard(
            icon: Icons.inventory_2_outlined,
            title: 'Simpan dulu',
            description:
                'Parkir proyek dengan rapi dan beri ruang untuk fokus lain.',
            selected: _decision == CycleDecision.park,
            onTap: () => _select(CycleDecision.park),
          ),
          if (_decision == CycleDecision.pivot) ...[
            const SizedBox(height: AppSpacing.section),
            const AppSectionHeader(
              title: 'Pendekatan baru',
              description:
                  'Tulis cara yang akan diuji. Tujuan utama proyek tidak berubah.',
            ),
            const SizedBox(height: AppSpacing.standard),
            TextField(
              controller: _pivotApproach,
              focusNode: _pivotFocus,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              onChanged: (_) {
                if (_showPivotError || _submitError != null) {
                  setState(() {
                    _showPivotError = false;
                    _submitError = null;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Pendekatan baru',
                hintText: 'Contoh: fokus pada video demo singkat setiap hari.',
                alignLabelWithHint: true,
                errorText: _showPivotError
                    ? 'Pendekatan baru wajib diisi.'
                    : null,
              ),
            ),
          ],
          if (_decision == CycleDecision.park) ...[
            const SizedBox(height: AppSpacing.section),
            ParkReplacementPicker(
              projects: projects,
              currentProjectId: widget.projectId,
              selectedProjectId: _replacementProjectId,
              onSelected: (projectId) {
                setState(() {
                  _replacementProjectId = projectId;
                  _submitError = null;
                });
              },
              onRetry: () => ref.invalidate(projectsProvider),
            ),
          ],
          if (_submitError case final error?) ...[
            const SizedBox(height: AppSpacing.section),
            AppNotice(
              icon: Icons.error_outline_rounded,
              title: 'Keputusan belum tersimpan',
              description: error,
              background: AppColors.dangerSoft,
              foreground: AppColors.danger,
            ),
          ],
        ],
      ),
    );
  }

  String get _submitLabel {
    if (_submitting) return 'Menyimpan…';
    return switch (_decision) {
      CycleDecision.continueFocus => 'Mulai putaran baru',
      CycleDecision.pivot => 'Simpan pendekatan baru',
      CycleDecision.park => 'Simpan proyek dulu',
      null => 'Pilih arah dulu',
    };
  }

  void _select(CycleDecision decision) {
    setState(() {
      _decision = decision;
      _showPivotError = false;
      _submitError = null;
    });
  }

  Future<void> _submit(Sprint sprint, ResultsSummary? summary) async {
    if (_submitting) return;
    final decision = _decision;
    if (decision == null) return;

    final approach = _pivotApproach.text.trim();
    if (decision == CycleDecision.pivot && approach.isEmpty) {
      setState(() => _showPivotError = true);
      _pivotFocus.requestFocus();
      return;
    }

    setState(() {
      _submitting = true;
      _submitError = null;
    });
    try {
      await ref
          .read(cycleClosureControllerProvider)
          .submit(
            CloseCycleInput(
              projectId: widget.projectId,
              sprintId: sprint.id,
              decision: decision,
              decidedAt: DateTime.now(),
              evidenceSummary: _evidenceSummary(summary),
              nextApproach: decision == CycleDecision.pivot ? approach : null,
              replacementProjectId: decision == CycleDecision.park
                  ? _replacementProjectId
                  : null,
            ),
          );
      if (!mounted) return;
      if (!MediaQuery.disableAnimationsOf(context)) {
        await HapticFeedback.mediumImpact();
      }
      if (!mounted) return;
      if (decision == CycleDecision.park && _replacementProjectId == null) {
        context.go('/projects');
      } else {
        context.go('/today');
      }
    } on AppException catch (error) {
      if (mounted) setState(() => _submitError = error.message);
    } catch (_) {
      if (mounted) {
        setState(
          () => _submitError =
              'Keputusan belum dapat disimpan. Pilihan dan tulisanmu tetap ada di layar ini.',
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String? _evidenceSummary(ResultsSummary? summary) {
    if (summary == null) return null;
    if (!summary.hasData) return 'Belum ada metrik tercatat pada putaran ini.';
    return '${summary.outputs} output; ${summary.views} tayangan; '
        '${summary.orders} pesanan; ${MoneyUnits.formatMinor(summary.revenueMinor)} omzet; '
        '${summary.workMinutes} menit kerja.';
  }

  void _leave() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/results');
    }
  }

  DateTime _localDay(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  String _date(DateTime value) =>
      DateFormat('d MMM y', 'id_ID').format(value.toLocal());
}

class _CycleReviewLoading extends StatelessWidget {
  const _CycleReviewLoading();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.generous,
          AppSpacing.compact,
          AppSpacing.generous,
          AppSpacing.section,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppLoadingBlock(height: 72),
            SizedBox(height: AppSpacing.section),
            AppLoadingBlock(height: 184),
            SizedBox(height: AppSpacing.section),
            AppLoadingBlock(height: 96),
          ],
        ),
      ),
    );
  }
}
