import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/services/money_units.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

class MetricEntryScreen extends ConsumerStatefulWidget {
  const MetricEntryScreen({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<MetricEntryScreen> createState() => _MetricEntryScreenState();
}

class _MetricEntryScreenState extends ConsumerState<MetricEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _outputs = TextEditingController(text: '0');
  final _views = TextEditingController();
  final _clicks = TextEditingController();
  final _orders = TextEditingController();
  final _revenue = TextEditingController();
  final _minutes = TextEditingController();
  final _note = TextEditingController();
  DateTime _date = DateTime.now();
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
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
    final entry = await ref
        .read(resultsRepositoryProvider)
        .getMetric(widget.projectId, _date);
    if (!mounted) return;
    if (entry != null) {
      _outputs.text = '${entry.outputsCount}';
      _views.text = _text(entry.views);
      _clicks.text = _text(entry.clicks);
      _orders.text = _text(entry.orders);
      _revenue.text = entry.revenueMinor == null
          ? ''
          : '${entry.revenueMinor! ~/ 100}';
      _minutes.text = _text(entry.workMinutes);
      _note.text = entry.note ?? '';
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Catat hasil harian'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.generous),
                children: [
                  OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today_outlined),
                    label: Text(DateFormat('d MMMM y', 'id_ID').format(_date)),
                  ),
                  const SizedBox(height: AppSpacing.standard),
                  _numberField(_outputs, 'Output diterbitkan', required: true),
                  const SizedBox(height: AppSpacing.innerCompact),
                  Row(
                    children: [
                      Expanded(child: _numberField(_views, 'Views')),
                      const SizedBox(width: AppSpacing.innerCompact),
                      Expanded(child: _numberField(_clicks, 'Klik')),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.innerCompact),
                  Row(
                    children: [
                      Expanded(child: _numberField(_orders, 'Order')),
                      const SizedBox(width: AppSpacing.innerCompact),
                      Expanded(child: _numberField(_minutes, 'Menit kerja')),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.innerCompact),
                  TextFormField(
                    controller: _revenue,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Pendapatan (rupiah)',
                      prefixText: 'Rp ',
                    ),
                    validator: _nonNegative,
                  ),
                  const SizedBox(height: AppSpacing.innerCompact),
                  TextFormField(
                    controller: _note,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Catatan'),
                  ),
                  const SizedBox(height: AppSpacing.section),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: Text(_saving ? 'Menyimpan…' : 'Simpan hasil'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _numberField(
    TextEditingController controller,
    String label, {
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Wajib diisi';
        }
        return _nonNegative(value);
      },
    );
  }

  String? _nonNegative(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final parsed = int.tryParse(value.replaceAll(RegExp(r'[^0-9-]'), ''));
    return parsed == null || parsed < 0 ? 'Angka tidak valid' : null;
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (value == null) return;
    setState(() {
      _date = value;
      _loading = true;
    });
    await _load();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(resultsRepositoryProvider)
          .saveMetric(
            MetricInput(
              projectId: widget.projectId,
              entryDate: _date,
              outputsCount: int.parse(_outputs.text),
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
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  int? _int(String value) => value.trim().isEmpty ? null : int.parse(value);
  String _text(int? value) => value == null ? '' : '$value';
}
