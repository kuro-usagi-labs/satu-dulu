import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/services/money_units.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

class MetricEntryScreen extends ConsumerStatefulWidget {
  const MetricEntryScreen({
    required this.projectId,
    this.fromShip = false,
    super.key,
  });

  final String projectId;
  final bool fromShip;

  @override
  ConsumerState<MetricEntryScreen> createState() => _MetricEntryScreenState();
}

class _MetricEntryScreenState extends ConsumerState<MetricEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _outputs;
  final _views = TextEditingController();
  final _clicks = TextEditingController();
  final _orders = TextEditingController();
  final _revenue = TextEditingController();
  final _minutes = TextEditingController();
  final _note = TextEditingController();
  DateTime _date = DateTime.now();
  bool _loading = true;
  bool _saving = false;
  int _loadRequest = 0;
  String? _loadError;
  String? _saveError;

  @override
  void initState() {
    super.initState();
    _outputs = TextEditingController(text: widget.fromShip ? '1' : '0');
    _load();
  }

  @override
  void dispose() {
    for (final controller in [
      _outputs,
      _views,
      _clicks,
      _orders,
      _revenue,
      _minutes,
      _note,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final request = ++_loadRequest;
    final requestedDate = _date;
    if (mounted) {
      setState(() {
        _loading = true;
        _loadError = null;
        _saveError = null;
      });
    }

    try {
      final entry = await ref
          .read(resultsRepositoryProvider)
          .getMetric(widget.projectId, requestedDate);
      if (!mounted || request != _loadRequest) return;
      _fillControllers(entry);
      setState(() => _loading = false);
    } on AppException catch (error) {
      if (!mounted || request != _loadRequest) return;
      setState(() {
        _loading = false;
        _loadError = error.message;
      });
    } catch (_) {
      if (!mounted || request != _loadRequest) return;
      setState(() {
        _loading = false;
        _loadError = 'Catatan untuk tanggal ini belum dapat dibuka.';
      });
    }
  }

  void _fillControllers(MetricEntry? entry) {
    _outputs.text = entry == null
        ? widget.fromShip
              ? '1'
              : '0'
        : '${entry.outputsCount}';
    _views.text = _text(entry?.views);
    _clicks.text = _text(entry?.clicks);
    _orders.text = _text(entry?.orders);
    _revenue.text = entry?.revenueMinor == null
        ? ''
        : '${entry!.revenueMinor! ~/ 100}';
    _minutes.text = _text(entry?.workMinutes);
    _note.text = entry?.note ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Catat bukti'),
      ),
      body: SafeArea(
        bottom: false,
        child: _loading
            ? const _MetricLoading()
            : _loadError != null
            ? _MetricLoadError(message: _loadError!, onRetry: _load)
            : Form(
                key: _formKey,
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.generous,
                    AppSpacing.section,
                    AppSpacing.generous,
                    AppSpacing.screen,
                  ),
                  children: [
                    const AppEyebrow('Bukti harian'),
                    const SizedBox(height: AppSpacing.compact),
                    Text(
                      'Apa yang benar-benar terjadi?',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.compact),
                    Text(
                      'Catat yang kamu tahu. Angka kosong boleh dilengkapi nanti.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.section),
                    OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: Text(
                        DateFormat('EEEE, d MMMM y', 'id_ID').format(_date),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.major),
                    if (widget.fromShip) ...[
                      const AppNotice(
                        icon: Icons.check_circle_outline_rounded,
                        title: 'Satu output sudah dibawa dari Ship Hari Ini',
                        description:
                            'Jumlah output dimulai dari 1. Ubah bila hari ini kamu mengirim lebih dari satu.',
                        background: AppColors.successSoft,
                        foreground: AppColors.success,
                      ),
                      const SizedBox(height: AppSpacing.section),
                    ],
                    const AppSectionHeader(
                      title: 'Yang dikirim',
                      description:
                          'Mulai dari output; inilah bukti utama eksperimen.',
                    ),
                    const SizedBox(height: AppSpacing.standard),
                    _numberField(
                      _outputs,
                      'Jumlah output',
                      required: true,
                      helperText: 'Isi 0 jika belum ada output pada hari ini.',
                    ),
                    const SizedBox(height: AppSpacing.major),
                    const AppSectionHeader(
                      title: 'Respons',
                      description:
                          'Isi hanya angka yang sudah tersedia di platformmu.',
                    ),
                    const SizedBox(height: AppSpacing.standard),
                    _numberField(_views, 'Tayangan'),
                    const SizedBox(height: AppSpacing.innerCompact),
                    _numberField(_clicks, 'Klik'),
                    const SizedBox(height: AppSpacing.innerCompact),
                    _numberField(_orders, 'Order'),
                    const SizedBox(height: AppSpacing.major),
                    const AppSectionHeader(
                      title: 'Waktu dan nilai',
                      description:
                          'Konteks ini membantu membaca hasil dengan lebih jujur.',
                    ),
                    const SizedBox(height: AppSpacing.standard),
                    _numberField(_minutes, 'Waktu kerja', suffixText: 'menit'),
                    const SizedBox(height: AppSpacing.innerCompact),
                    TextFormField(
                      controller: _revenue,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Pendapatan',
                        prefixText: 'Rp ',
                      ),
                      validator: _nonNegative,
                    ),
                    const SizedBox(height: AppSpacing.major),
                    AppSectionHeader(
                      title: 'Catatan kecil',
                      description:
                          'Simpan konteks yang tidak terlihat dari angka.',
                    ),
                    const SizedBox(height: AppSpacing.standard),
                    TextFormField(
                      controller: _note,
                      minLines: 3,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Apa yang layak diingat?',
                        alignLabelWithHint: true,
                        hintText:
                            'Contoh: respons datang setelah judul diubah.',
                      ),
                    ),
                    if (_saveError case final error?) ...[
                      const SizedBox(height: AppSpacing.section),
                      AppNotice(
                        icon: Icons.error_outline_rounded,
                        title: 'Bukti belum tersimpan',
                        description: error,
                        background: AppColors.dangerSoft,
                        foreground: AppColors.danger,
                      ),
                    ],
                  ],
                ),
              ),
      ),
      bottomNavigationBar: AppBottomActionBar(
        child: FilledButton(
          onPressed: _loading || _loadError != null || _saving ? null : _save,
          child: Text(_saving ? 'Menyimpan…' : 'Simpan bukti'),
        ),
      ),
    );
  }

  Widget _numberField(
    TextEditingController controller,
    String label, {
    bool required = false,
    String? helperText,
    String? suffixText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        suffixText: suffixText,
      ),
      validator: (value) {
        if (required && (value == null || value.trim().isEmpty)) {
          return 'Wajib diisi';
        }
        return _nonNegative(value);
      },
    );
  }

  String? _nonNegative(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final parsed = int.tryParse(value.replaceAll(RegExp(r'[^0-9-]'), ''));
    return parsed == null || parsed < 0 ? 'Masukkan angka 0 atau lebih' : null;
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      helpText: 'Pilih tanggal bukti',
    );
    if (value == null || DateUtils.isSameDay(value, _date)) return;
    setState(() => _date = value);
    await _load();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      await ref
          .read(resultsRepositoryProvider)
          .saveMetric(
            MetricInput(
              projectId: widget.projectId,
              entryDate: _date,
              outputsCount: _int(_outputs.text) ?? 0,
              views: _int(_views.text),
              clicks: _int(_clicks.text),
              orders: _int(_orders.text),
              revenueMinor: MoneyUnits.rupiahTextToMinor(_revenue.text),
              workMinutes: _int(_minutes.text),
              note: _note.text,
            ),
          );
      if (mounted) context.pop();
    } on AppException catch (error) {
      if (mounted) setState(() => _saveError = error.message);
    } catch (_) {
      if (mounted) {
        setState(
          () => _saveError =
              'Bukti belum dapat disimpan. Coba lagi tanpa menutup layar ini.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  int? _int(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.isEmpty ? null : int.parse(digits);
  }

  String _text(int? value) => value == null ? '' : '$value';
}

class _MetricLoading extends StatelessWidget {
  const _MetricLoading();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: const [
        AppLoadingBlock(height: 96),
        SizedBox(height: AppSpacing.section),
        AppLoadingBlock(height: 64),
        SizedBox(height: AppSpacing.innerCompact),
        AppLoadingBlock(height: 64),
      ],
    );
  }
}

class _MetricLoadError extends StatelessWidget {
  const _MetricLoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: [
        AppNotice(
          icon: Icons.sync_problem_outlined,
          title: 'Catatan belum dapat dibuka',
          description: message,
          background: AppColors.dangerSoft,
          foreground: AppColors.danger,
        ),
        const SizedBox(height: AppSpacing.standard),
        OutlinedButton(onPressed: onRetry, child: const Text('Muat lagi')),
      ],
    );
  }
}
