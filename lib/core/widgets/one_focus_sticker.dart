import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';

/// A small vector story: several safe ideas converge into one active focus.
class OneFocusSticker extends StatelessWidget {
  const OneFocusSticker({this.size = 168, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Semantics(
      image: true,
      label: 'Beberapa ide mengarah ke satu fokus utama.',
      child: ExcludeSemantics(
        child: SizedBox.square(
          dimension: size,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: reduceMotion ? Duration.zero : AppDuration.success,
            curve: Curves.easeOutCubic,
            builder: (context, progress, child) =>
                CustomPaint(painter: _OneFocusStickerPainter(progress)),
          ),
        ),
      ),
    );
  }
}

class _OneFocusStickerPainter extends CustomPainter {
  const _OneFocusStickerPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-0.035 * progress);
    canvas.translate(-center.dx, -center.dy);

    final stickerRect = Rect.fromLTWH(
      size.width * 0.08,
      size.height * 0.12,
      size.width * 0.84,
      size.height * 0.76,
    );
    final sticker = RRect.fromRectAndRadius(
      stickerRect,
      Radius.circular(size.width * 0.16),
    );
    canvas.drawRRect(sticker, Paint()..color = AppColors.surface);
    canvas.drawRRect(
      sticker,
      Paint()
        ..color = AppColors.textPrimary
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1.5, size.width * 0.012),
    );

    final sourcePoints = [
      Offset(size.width * 0.28, size.height * 0.31),
      Offset(size.width * 0.24, size.height * 0.52),
      Offset(size.width * 0.31, size.height * 0.71),
    ];
    final sourceColors = [
      AppColors.guide,
      AppColors.maintenance,
      AppColors.parking,
    ];
    final target = Offset(size.width * 0.67, size.height * 0.51);
    final routePaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(1.5, size.width * 0.014);

    for (var index = 0; index < sourcePoints.length; index++) {
      final source = sourcePoints[index];
      final path = Path()
        ..moveTo(source.dx, source.dy)
        ..quadraticBezierTo(
          size.width * 0.48,
          source.dy,
          target.dx - size.width * 0.1,
          target.dy,
        );
      final metric = path.computeMetrics().first;
      canvas.drawPath(
        metric.extractPath(0, metric.length * progress),
        routePaint,
      );
      canvas.drawCircle(
        source,
        size.width * 0.04 * progress,
        Paint()..color = sourceColors[index],
      );
    }

    final targetScale = Curves.easeOutBack.transform(progress);
    canvas.drawCircle(
      target,
      size.width * 0.17 * targetScale,
      Paint()..color = AppColors.textPrimary,
    );
    canvas.drawCircle(
      target,
      size.width * 0.095 * targetScale,
      Paint()..color = AppColors.action,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: '1',
        style: TextStyle(
          color: AppColors.onAction,
          fontSize: size.width * 0.11,
          height: 1,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      target - Offset(textPainter.width / 2, textPainter.height / 2),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OneFocusStickerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
