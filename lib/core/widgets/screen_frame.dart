import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';

class ScreenFrame extends StatelessWidget {
  const ScreenFrame({
    required this.title,
    required this.child,
    this.eyebrow,
    this.subtitle,
    this.trailing,
    super.key,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.generous,
              AppSpacing.section,
              AppSpacing.generous,
              116,
            ),
            sliver: SliverList.list(
              children: [
                if (eyebrow case final eyebrow?) ...[
                  AppEyebrow(eyebrow),
                  const SizedBox(height: AppSpacing.compact),
                ] else ...[
                  Container(
                    width: 32,
                    height: 4,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.innerCompact),
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    if (trailing case final trailing?) ...[
                      const SizedBox(width: AppSpacing.innerCompact),
                      trailing,
                    ],
                  ],
                ),
                if (subtitle case final subtitle?) ...[
                  const SizedBox(height: AppSpacing.compact),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.major),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
