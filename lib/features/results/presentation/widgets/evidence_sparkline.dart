import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';

class EvidenceSparkline extends StatelessWidget {
  const EvidenceSparkline({required this.entries, super.key});

  final List<MetricEntry> entries;

  @override
  Widget build(BuildContext context) {
    final values = entries
        .take(7)
        .toList(growable: false)
        .reversed
        .map((entry) => entry.outputsCount.toDouble())
        .toList(growable: false);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Semantics(
      image: true,
      label: values.isEmpty
          ? 'Belum ada tren output.'
          : 'Tren output dari ${values.length} catatan terakhir.',
      child: ExcludeSemantics(
        child: SizedBox(
          height: 92,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: reduceMotion ? Duration.zero : AppDuration.card,
            curve: Curves.easeOutCubic,
            builder: (context, progress, child) => CustomPaint(
              painter: _SparklinePainter(values: values, progress: progress),
              size: Size.infinite,
            ),
          ),
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({required this.values, required this.progress});

  final List<double> values;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final baselinePaint = Paint()
      ..color = AppColors.evidenceMuted.withValues(alpha: 0.2)
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = AppColors.action
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final dotPaint = Paint()..color = AppColors.action;

    canvas.drawLine(
      Offset(0, size.height - 10),
      Offset(size.width, size.height - 10),
      baselinePaint,
    );

    if (values.isEmpty) return;

    final maxValue = values
        .reduce((a, b) => a > b ? a : b)
        .clamp(1, double.infinity);
    final horizontalStep = values.length == 1
        ? 0.0
        : size.width / (values.length - 1);
    final points = <Offset>[
      for (var index = 0; index < values.length; index++)
        Offset(
          values.length == 1 ? size.width / 2 : horizontalStep * index,
          size.height - 12 - (values[index] / maxValue) * (size.height - 28),
        ),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }

    final metric = path.computeMetrics().firstOrNull;
    if (metric != null) {
      canvas.drawPath(
        metric.extractPath(0, metric.length * progress),
        linePaint,
      );
    }

    final visiblePointCount = (points.length * progress).ceil().clamp(
      0,
      points.length,
    );
    for (final point in points.take(visiblePointCount)) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.values != values;
  }
}
