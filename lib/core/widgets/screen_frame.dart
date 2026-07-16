import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';

class ScreenFrame extends StatelessWidget {
  const ScreenFrame({
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.generous,
              AppSpacing.section,
              AppSpacing.generous,
              AppSpacing.section,
            ),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    ?trailing,
                  ],
                ),
                if (subtitle case final subtitle?) ...[
                  const SizedBox(height: AppSpacing.compact),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.section),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
