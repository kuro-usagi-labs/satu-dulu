import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

class WeeklyReviewScreen extends ConsumerStatefulWidget {
  const WeeklyReviewScreen({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<WeeklyReviewScreen> createState() => _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends ConsumerState<WeeklyReviewScreen> {
  final _shipped = TextEditingController();
  final _important = TextEditingController();
  final _worked = TextEditingController();
  final _waste = TextEditingController();
  final _next = TextEditingController();
  ReviewDecision _decision = ReviewDecision.continueFocus;
  bool _saving = false;

  @override
  void dispose() {
    for (final controller in [_shipped, _important, _worked, _waste, _next]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Review mingguan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.generous),
        children: [
          _prompt(_shipped, '1. Apa yang diterbitkan minggu ini?'),
          _prompt(_important, '2. Hasil paling penting apa?'),
          _prompt(_worked, '3. Apa yang bekerja dengan baik?'),
          _prompt(_waste, '4. Apa yang membuang waktu atau menghambat?'),
          Text('5. Keputusan', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.compact),
          SegmentedButton<ReviewDecision>(
            segments: const [
              ButtonSegment(
                value: ReviewDecision.continueFocus,
                label: Text('Lanjut'),
              ),
              ButtonSegment(value: ReviewDecision.pivot, label: Text('Pivot')),
              ButtonSegment(value: ReviewDecision.park, label: Text('Parkir')),
            ],
            selected: {_decision},
            onSelectionChanged: (value) {
              setState(() => _decision = value.single);
            },
          ),
          const SizedBox(height: AppSpacing.section),
          _prompt(_next, '6. Fokus minggu depan'),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? 'Menyimpan…' : 'Simpan review'),
          ),
        ],
      ),
    );
  }

  Widget _prompt(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.section),
      child: TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(labelText: label, alignLabelWithHint: true),
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final now = DateTime.now();
    final start = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    await ref
        .read(resultsRepositoryProvider)
        .saveWeeklyReview(
          WeeklyReviewInput(
            projectId: widget.projectId,
            weekStart: start,
            weekEnd: start.add(const Duration(days: 6)),
            shippedSummary: _shipped.text,
            importantResult: _important.text,
            workedWell: _worked.text,
            wasteOrBlocker: _waste.text,
            decision: _decision,
            nextWeekFocus: _next.text,
          ),
        );
    if (mounted) context.pop();
  }
}
