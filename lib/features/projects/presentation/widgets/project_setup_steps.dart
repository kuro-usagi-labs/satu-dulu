import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

class ProjectIdentityStep extends StatelessWidget {
  const ProjectIdentityStep({
    required this.nameController,
    required this.goalController,
    required this.whyController,
    required this.nameValidator,
    required this.goalValidator,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController goalController;
  final TextEditingController whyController;
  final FormFieldValidator<String> nameValidator;
  final FormFieldValidator<String> goalValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: nameController,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Nama fokus',
            hintText: 'Contoh: Channel tutorial Flutter',
          ),
          validator: nameValidator,
        ),
        const SizedBox(height: AppSpacing.standard),
        TextFormField(
          controller: goalController,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Apa yang ingin kamu buktikan?',
            hintText: 'Tujuan singkat untuk 30 hari ini',
            alignLabelWithHint: true,
          ),
          validator: goalValidator,
        ),
        const SizedBox(height: AppSpacing.standard),
        TextFormField(
          controller: whyController,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Kenapa ini penting sekarang? (opsional)',
            hintText: 'Alasan yang akan kamu baca lagi saat kehilangan arah',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        const AppNotice(
          icon: Icons.inventory_2_outlined,
          title: 'Ide lain tidak hilang',
          description:
              'Kamu bisa menyimpannya di “Disimpan dulu” tanpa membiarkannya memenuhi Hari Ini.',
        ),
      ],
    );
  }
}

class ProjectFinishLineStep extends StatelessWidget {
  const ProjectFinishLineStep({
    required this.successController,
    required this.outcomeController,
    required this.outcomeValidator,
    super.key,
  });

  final TextEditingController successController;
  final TextEditingController outcomeController;
  final FormFieldValidator<String> outcomeValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppNotice(
          icon: Icons.science_outlined,
          title: 'Anggap ini eksperimen',
          description:
              'Setelah 30 hari, bukti membantumu memilih: lanjut, ubah pendekatan, atau simpan dulu.',
          background: AppColors.guideSoft,
          foreground: AppColors.guide,
        ),
        const SizedBox(height: AppSpacing.section),
        TextFormField(
          controller: successController,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Bukti 30 hari (opsional)',
            hintText: 'Contoh: terbit 8 video dan mendapat 3 calon pelanggan',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: AppSpacing.standard),
        TextFormField(
          controller: outcomeController,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Satu hasil yang akan di-Ship hari ini',
            hintText: 'Sesuatu yang benar-benar selesai atau diterbitkan',
            alignLabelWithHint: true,
          ),
          validator: outcomeValidator,
        ),
      ],
    );
  }
}

class ProjectFirstDayStep extends StatelessWidget {
  const ProjectFirstDayStep({
    required this.actionControllers,
    required this.lowEnergyController,
    required this.firstActionValidator,
    required this.showStatusOptions,
    required this.selectedStatus,
    required this.onStatusSelected,
    super.key,
  });

  final List<TextEditingController> actionControllers;
  final TextEditingController lowEnergyController;
  final FormFieldValidator<String> firstActionValidator;
  final bool showStatusOptions;
  final ProjectStatus selectedStatus;
  final ValueChanged<ProjectStatus> onStatusSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Langkah hari ini', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.micro),
        Text(
          'Urutkan dari langkah yang paling mudah dimulai.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.standard),
        for (var index = 0; index < actionControllers.length; index++) ...[
          _ActionField(
            index: index,
            controller: actionControllers[index],
            validator: index == 0 ? firstActionValidator : null,
          ),
          if (index < actionControllers.length - 1)
            const SizedBox(height: AppSpacing.innerCompact),
        ],
        const SizedBox(height: AppSpacing.section),
        _LowEnergyField(controller: lowEnergyController),
        if (showStatusOptions) ...[
          const SizedBox(height: AppSpacing.section),
          Text('Tempat proyek', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.compact),
          const Text(
            'Hanya satu fokus utama dan satu proyek yang tetap dijaga.',
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          _StatusOption(
            value: ProjectStatus.focus,
            selected: selectedStatus,
            icon: Icons.adjust_rounded,
            title: 'Fokus utama',
            description: 'Muncul setiap hari dan memimpin 30 hari ini.',
            onSelected: onStatusSelected,
          ),
          const SizedBox(height: AppSpacing.compact),
          _StatusOption(
            value: ProjectStatus.maintenance,
            selected: selectedStatus,
            icon: Icons.spa_outlined,
            title: 'Tetap dijaga',
            description: 'Tetap hidup, tetapi tidak mengambil alih Hari Ini.',
            onSelected: onStatusSelected,
          ),
          const SizedBox(height: AppSpacing.compact),
          _StatusOption(
            value: ProjectStatus.parkingLot,
            selected: selectedStatus,
            icon: Icons.inventory_2_outlined,
            title: 'Disimpan dulu',
            description: 'Aman untuk nanti dan tidak memecah fokus sekarang.',
            onSelected: onStatusSelected,
          ),
        ],
      ],
    );
  }
}

class _ActionField extends StatelessWidget {
  const _ActionField({
    required this.index,
    required this.controller,
    this.validator,
  });

  final int index;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.only(top: AppSpacing.compact),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: index == 0 ? AppColors.accent : AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          child: Text(
            '${index + 1}',
            style: AppTextStyles.number.copyWith(
              color: index == 0
                  ? AppColors.textInverse
                  : AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.innerCompact),
        Expanded(
          child: TextFormField(
            controller: controller,
            textInputAction: index == 2
                ? TextInputAction.done
                : TextInputAction.next,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: index == 0
                  ? 'Mulai dari sini'
                  : 'Langkah ${index + 1} (opsional)',
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}

class _LowEnergyField extends StatelessWidget {
  const _LowEnergyField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.warningSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.battery_2_bar_rounded,
                  color: AppColors.warning,
                ),
                const SizedBox(width: AppSpacing.compact),
                Expanded(
                  child: Text(
                    'Kalau energimu rendah',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            TextFormField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Versi paling kecil (opsional)',
                hintText: 'Contoh: tulis satu paragraf',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.value,
    required this.selected,
    required this.icon,
    required this.title,
    required this.description,
    required this.onSelected,
  });

  final ProjectStatus value;
  final ProjectStatus selected;
  final IconData icon;
  final String title;
  final String description;
  final ValueChanged<ProjectStatus> onSelected;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selected;
    return Semantics(
      selected: isSelected,
      button: true,
      child: InkWell(
        onTap: () => onSelected(value),
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: AnimatedContainer(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : AppDuration.stateChange,
          padding: const EdgeInsets.all(AppSpacing.standard),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accentSoft : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.input),
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.border,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AppColors.accentDeep
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.compact),
              Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: isSelected ? AppColors.accent : AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
