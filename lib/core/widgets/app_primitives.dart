import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';

class AppEyebrow extends StatelessWidget {
  const AppEyebrow(this.label, {this.color, super.key});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.eyebrow.copyWith(
        color: color ?? AppColors.accentDeep,
      ),
    );
  }
}

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    this.description,
    this.trailing,
    super.key,
  });

  final String title;
  final String? description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              if (description case final description?) ...[
                const SizedBox(height: AppSpacing.micro),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing case final trailing?) ...[
          const SizedBox(width: AppSpacing.innerCompact),
          trailing,
        ],
      ],
    );
  }
}

class AppIconBadge extends StatelessWidget {
  const AppIconBadge({
    required this.icon,
    this.foreground = AppColors.accentDeep,
    this.background = AppColors.accentSoft,
    this.size = 48,
    super.key,
  });

  final IconData icon;
  final Color foreground;
  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(icon, color: foreground, size: size * 0.48),
    );
  }
}

enum AppStatusTone {
  focus,
  maintenance,
  parking,
  guide,
  success,
  warning,
  danger,
  neutral,
}

class AppStatusPill extends StatelessWidget {
  const AppStatusPill({
    required this.label,
    required this.tone,
    this.icon,
    super.key,
  });

  final String label;
  final AppStatusTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final palette = switch (tone) {
      AppStatusTone.focus => const _StatusPalette(
        background: AppColors.action,
        foreground: AppColors.onAction,
      ),
      AppStatusTone.maintenance => const _StatusPalette(
        background: AppColors.maintenanceSoft,
        foreground: AppColors.maintenance,
      ),
      AppStatusTone.parking => const _StatusPalette(
        background: AppColors.parkingSoft,
        foreground: AppColors.parking,
      ),
      AppStatusTone.guide => const _StatusPalette(
        background: AppColors.guideSoft,
        foreground: AppColors.guide,
      ),
      AppStatusTone.success => const _StatusPalette(
        background: AppColors.successSoft,
        foreground: AppColors.success,
      ),
      AppStatusTone.warning => const _StatusPalette(
        background: AppColors.warningSoft,
        foreground: AppColors.warning,
      ),
      AppStatusTone.danger => const _StatusPalette(
        background: AppColors.dangerSoft,
        foreground: AppColors.danger,
      ),
      AppStatusTone.neutral => const _StatusPalette(
        background: AppColors.surfaceSecondary,
        foreground: AppColors.textSecondary,
      ),
    };

    return Semantics(
      label: label,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.innerCompact,
            vertical: AppSpacing.micro,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon case final icon?) ...[
                Icon(icon, size: 14, color: palette.foreground),
                const SizedBox(width: AppSpacing.micro),
              ],
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: palette.foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppFocusCard extends StatelessWidget {
  const AppFocusCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.generous),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.actionSoft,
        borderRadius: BorderRadius.circular(AppRadius.hero),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class AppEvidenceCard extends StatelessWidget {
  const AppEvidenceCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.generous),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.evidence,
        borderRadius: BorderRadius.circular(AppRadius.hero),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: AppColors.onEvidence),
        child: IconTheme.merge(
          data: const IconThemeData(color: AppColors.onEvidence),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class AppActionButton extends StatelessWidget {
  const AppActionButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final callback = isLoading ? null : onPressed;
    final button = icon == null
        ? FilledButton(onPressed: callback, child: Text(label))
        : FilledButton.icon(
            onPressed: callback,
            icon: Icon(icon),
            label: Text(label),
          );

    return AppPressScale(enabled: callback != null, child: button);
  }
}

class AppPressScale extends StatefulWidget {
  const AppPressScale({required this.child, this.enabled = true, super.key});

  final Widget child;
  final bool enabled;

  @override
  State<AppPressScale> createState() => _AppPressScaleState();
}

class _AppPressScaleState extends State<AppPressScale> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Listener(
      onPointerDown: widget.enabled ? (_) => _setPressed(true) : null,
      onPointerUp: widget.enabled ? (_) => _setPressed(false) : null,
      onPointerCancel: widget.enabled ? (_) => _setPressed(false) : null,
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: reduceMotion ? Duration.zero : AppDuration.tap,
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }
}

class AppEntrance extends StatelessWidget {
  const AppEntrance({
    required this.child,
    this.offset = 8,
    this.duration = AppDuration.card,
    super.key,
  });

  final Widget child;
  final double offset;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: reduceMotion ? Duration.zero : duration,
      curve: Curves.easeOutCubic,
      builder: (context, progress, child) => Opacity(
        opacity: progress,
        child: Transform.translate(
          offset: Offset(0, offset * (1 - progress)),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

class _StatusPalette {
  const _StatusPalette({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}

class AppStepRow extends StatelessWidget {
  const AppStepRow({
    required this.number,
    required this.title,
    required this.description,
    this.isLast = false,
    this.highlighted = false,
    super.key,
  });

  final int number;
  final String title;
  final String description;
  final bool isLast;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: highlighted
                        ? AppColors.accent
                        : AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: Text(
                    '$number',
                    style: AppTextStyles.number.copyWith(
                      color: highlighted
                          ? AppColors.onAction
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      margin: const EdgeInsets.symmetric(
                        vertical: AppSpacing.compact,
                      ),
                      color: AppColors.divider,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.innerCompact),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: AppSpacing.micro,
                bottom: isLast ? 0 : AppSpacing.generous,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppNotice extends StatelessWidget {
  const AppNotice({
    required this.icon,
    required this.title,
    required this.description,
    this.background = AppColors.surfaceSecondary,
    this.foreground = AppColors.textPrimary,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: foreground, size: 22),
            const SizedBox(width: AppSpacing.innerCompact),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: foreground),
                  ),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: foreground),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppLoadingBlock extends StatelessWidget {
  const AppLoadingBlock({this.height = 104, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Memuat',
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),
    );
  }
}

class AppBottomActionBar extends StatelessWidget {
  const AppBottomActionBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(
          AppSpacing.generous,
          AppSpacing.innerCompact,
          AppSpacing.generous,
          AppSpacing.innerCompact,
        ),
        child: child,
      ),
    );
  }
}
