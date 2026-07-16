import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

class TodayActionTile extends StatelessWidget {
  const TodayActionTile({
    required this.action,
    required this.enabled,
    required this.onChanged,
    super.key,
  });

  final DailyAction action;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: action.isCompleted,
        onChanged: enabled ? (value) => onChanged(value ?? false) : null,
        title: Text(
          action.label,
          style: TextStyle(
            decoration: action.isCompleted ? TextDecoration.lineThrough : null,
            color: action.isCompleted ? AppColors.textTertiary : null,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),
    );
  }
}

class LowEnergyCard extends StatelessWidget {
  const LowEnergyCard({required this.action, super.key});

  final String? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.warningSoft,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kecilkan langkahnya, jangan hilangkan arahnya.',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              action?.isNotEmpty == true
                  ? action!
                  : 'Pilih tindakan terkecil yang masih bisa kamu selesaikan.',
            ),
          ],
        ),
      ),
    );
  }
}

class RecoveryItem extends StatelessWidget {
  const RecoveryItem({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.micro),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class TodayErrorCard extends StatelessWidget {
  const TodayErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.standard),
        child: Text(
          'Rencana hari ini belum dapat dimuat. Coba buka ulang aplikasi.',
        ),
      ),
    );
  }
}
