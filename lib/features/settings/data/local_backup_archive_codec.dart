import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';

class LocalBackupArchiveCodec {
  const LocalBackupArchiveCodec();

  static const _manifestPath = 'manifest.json';
  static const _dataPath = 'data.json';
  static const _maxJsonBytes = 20 * 1024 * 1024;
  static final _pdfPathPattern = RegExp(r'^pdfs/[a-zA-Z0-9-]+\.pdf$');
  static final _shaPattern = RegExp(r'^[a-f0-9]{64}$');

  EncodedLocalBackup encode({
    required BackupDataSnapshot snapshot,
    required Map<String, Uint8List> pdfBytes,
    required DateTime createdAt,
  }) {
    try {
      _validatePdfPayload(snapshot, pdfBytes);
      final dataBytes = _jsonBytes(snapshot.toJson());
      if (dataBytes.length > _maxJsonBytes) {
        throw const BackupException(
          'Data aplikasi terlalu besar untuk format backup saat ini.',
        );
      }

      final sortedPaths = pdfBytes.keys.toList()..sort();
      final pdfEntries = <BackupPdfEntry>[
        for (final path in sortedPaths)
          BackupPdfEntry(
            path: path,
            sizeBytes: pdfBytes[path]!.length,
            sha256: sha256.convert(pdfBytes[path]!).toString(),
          ),
      ];
      final manifest = LocalBackupManifest(
        createdAt: createdAt.toUtc(),
        databaseSchemaVersion: snapshot.databaseSchemaVersion,
        dataSha256: sha256.convert(dataBytes).toString(),
        counts: Map.unmodifiable(snapshot.counts),
        pdfs: List.unmodifiable(pdfEntries),
      );
      final manifestBytes = _jsonBytes(manifest.toJson());
      final archive = Archive()
        ..add(ArchiveFile.bytes(_manifestPath, manifestBytes))
        ..add(ArchiveFile.bytes(_dataPath, dataBytes));
      for (final path in sortedPaths) {
        archive.add(ArchiveFile.bytes(path, pdfBytes[path]!));
      }

      final bytes = ZipEncoder().encodeBytes(archive);
      if (bytes.length > maxLocalBackupBytes) {
        throw const BackupException(
          'Backup melebihi batas 256 MB. Kurangi PDF besar lalu coba lagi.',
        );
      }
      return EncodedLocalBackup(bytes: bytes, manifest: manifest);
    } on BackupException {
      rethrow;
    } catch (error) {
      throw BackupException('Backup belum dapat dibuat.', error);
    }
  }

  PreparedLocalBackup decode({
    required String sourceName,
    required Uint8List bytes,
  }) {
    if (bytes.isEmpty || bytes.length > maxLocalBackupBytes) {
      throw const BackupException(
        'Ukuran file backup tidak valid atau melebihi 256 MB.',
      );
    }

    try {
      final archive = ZipDecoder().decodeBytes(bytes);
      if (archive.isEmpty || archive.length > maxLocalBackupEntries) {
        throw const BackupException('Isi file backup tidak wajar.');
      }

      final entries = <String, ArchiveFile>{};
      var totalSize = 0;
      for (final entry in archive) {
        final name = entry.name;
        if (!entry.isFile || !_isAllowedArchivePath(name)) {
          throw const BackupException(
            'File backup berisi path yang tidak diizinkan.',
          );
        }
        if (entries.containsKey(name)) {
          throw const BackupException('File backup memiliki entry ganda.');
        }
        if (entry.size < 0) {
          throw const BackupException('Ukuran entry backup tidak valid.');
        }
        totalSize += entry.size;
        if (totalSize > maxLocalBackupBytes) {
          throw const BackupException('Isi backup melebihi batas aman 256 MB.');
        }
        entries[name] = entry;
      }

      final manifestEntry = entries[_manifestPath];
      final dataEntry = entries[_dataPath];
      if (manifestEntry == null || dataEntry == null) {
        throw const BackupException(
          'Manifest atau snapshot database tidak ditemukan.',
        );
      }
      final manifest = _parseManifest(manifestEntry.content);
      final dataBytes = dataEntry.content;
      if (dataBytes.length > _maxJsonBytes ||
          sha256.convert(dataBytes).toString() != manifest.dataSha256) {
        throw const BackupException('Snapshot database berubah atau rusak.');
      }
      final snapshot = BackupDataSnapshot.fromJson(
        _decodeJsonObject(dataBytes, 'Snapshot database'),
      );
      if (snapshot.databaseSchemaVersion != manifest.databaseSchemaVersion ||
          !_sameCounts(snapshot.counts, manifest.counts)) {
        throw const BackupException(
          'Manifest tidak cocok dengan isi database backup.',
        );
      }

      final expectedNames = <String>{_manifestPath, _dataPath};
      final pdfBytes = <String, Uint8List>{};
      for (final pdf in manifest.pdfs) {
        expectedNames.add(pdf.path);
        final entry = entries[pdf.path];
        if (entry == null) {
          throw const BackupException(
            'Salah satu PDF tidak ada di dalam backup.',
          );
        }
        final content = entry.content;
        if (content.length != pdf.sizeBytes ||
            sha256.convert(content).toString() != pdf.sha256 ||
            !_hasPdfHeader(content)) {
          throw const BackupException('Salah satu PDF di dalam backup rusak.');
        }
        pdfBytes[pdf.path] = Uint8List.fromList(content);
      }
      if (!_sameStrings(entries.keys.toSet(), expectedNames) ||
          !_sameStrings(snapshot.guidePaths.toSet(), pdfBytes.keys.toSet())) {
        throw const BackupException(
          'Daftar PDF tidak cocok dengan metadata panduan.',
        );
      }

      return PreparedLocalBackup(
        sourceName: sourceName,
        manifest: manifest,
        snapshot: snapshot,
        pdfBytes: Map.unmodifiable(pdfBytes),
      );
    } on BackupException {
      rethrow;
    } on FormatException catch (error) {
      throw BackupException('Format data backup tidak valid.', error);
    } catch (error) {
      throw BackupException(
        'File ini bukan backup Satu Dulu yang valid.',
        error,
      );
    }
  }

  LocalBackupManifest _parseManifest(Uint8List bytes) {
    if (bytes.length > _maxJsonBytes) {
      throw const BackupException('Manifest backup terlalu besar.');
    }
    final json = _decodeJsonObject(bytes, 'Manifest');
    if (json['format'] != localBackupFormat ||
        json['formatVersion'] != localBackupFormatVersion) {
      throw const BackupException(
        'Versi atau jenis file backup tidak didukung.',
      );
    }
    final createdAt = DateTime.tryParse(json['createdAtUtc'] as String? ?? '');
    final schema = json['databaseSchemaVersion'];
    final dataSha256 = json['dataSha256'];
    final rawCounts = json['counts'];
    final rawPdfs = json['pdfs'];
    if (createdAt == null ||
        schema is! int ||
        dataSha256 is! String ||
        !_shaPattern.hasMatch(dataSha256) ||
        rawCounts is! Map ||
        rawPdfs is! List) {
      throw const BackupException('Manifest backup tidak lengkap.');
    }

    final counts = <String, int>{};
    for (final name in localBackupTableNames) {
      final value = rawCounts[name];
      if (value is! int || value < 0) {
        throw const BackupException('Jumlah record backup tidak valid.');
      }
      counts[name] = value;
    }
    if (rawCounts.length != localBackupTableNames.length) {
      throw const BackupException('Daftar hitungan tabel tidak dikenali.');
    }

    final pdfs = <BackupPdfEntry>[];
    final paths = <String>{};
    for (final raw in rawPdfs) {
      if (raw is! Map) {
        throw const BackupException('Daftar PDF backup tidak valid.');
      }
      final path = raw['path'];
      final size = raw['sizeBytes'];
      final checksum = raw['sha256'];
      if (path is! String ||
          !_pdfPathPattern.hasMatch(path) ||
          size is! int ||
          size < 5 ||
          checksum is! String ||
          !_shaPattern.hasMatch(checksum) ||
          !paths.add(path)) {
        throw const BackupException('Metadata PDF backup tidak valid.');
      }
      pdfs.add(BackupPdfEntry(path: path, sizeBytes: size, sha256: checksum));
    }
    final sorted = [...pdfs]..sort((a, b) => a.path.compareTo(b.path));
    if (!_sameStrings(
      pdfs.map((entry) => entry.path).toSet(),
      sorted.map((entry) => entry.path).toSet(),
    )) {
      throw const BackupException('Urutan PDF backup tidak valid.');
    }
    return LocalBackupManifest(
      createdAt: createdAt.toUtc(),
      databaseSchemaVersion: schema,
      dataSha256: dataSha256,
      counts: Map.unmodifiable(counts),
      pdfs: List.unmodifiable(sorted),
    );
  }

  void _validatePdfPayload(
    BackupDataSnapshot snapshot,
    Map<String, Uint8List> pdfBytes,
  ) {
    if (!_sameStrings(snapshot.guidePaths.toSet(), pdfBytes.keys.toSet())) {
      throw const BackupException(
        'Semua PDF lokal harus tersedia sebelum backup dibuat.',
      );
    }
    var totalSize = 0;
    for (final entry in pdfBytes.entries) {
      if (!_pdfPathPattern.hasMatch(entry.key) || !_hasPdfHeader(entry.value)) {
        throw const BackupException('Salah satu PDF lokal tidak valid.');
      }
      totalSize += entry.value.length;
      if (totalSize > maxLocalBackupBytes) {
        throw const BackupException(
          'Total data dan PDF melebihi batas backup 256 MB.',
        );
      }
    }
  }

  bool _isAllowedArchivePath(String value) {
    if (value.contains('..') ||
        value.contains('\\') ||
        value.startsWith('/') ||
        value.contains(':')) {
      return false;
    }
    return value == _manifestPath ||
        value == _dataPath ||
        _pdfPathPattern.hasMatch(value);
  }

  bool _hasPdfHeader(List<int> bytes) {
    return bytes.length >= 5 &&
        bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46 &&
        bytes[4] == 0x2d;
  }

  Uint8List _jsonBytes(Object? value) {
    return Uint8List.fromList(utf8.encode(jsonEncode(_canonicalize(value))));
  }

  Map<String, dynamic> _decodeJsonObject(Uint8List bytes, String label) {
    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map) throw FormatException('$label bukan object JSON.');
    return Map<String, dynamic>.from(decoded);
  }

  Object? _canonicalize(Object? value) {
    if (value is Map) {
      final keys = value.keys.map((key) => key.toString()).toList()..sort();
      return <String, Object?>{
        for (final key in keys) key: _canonicalize(value[key]),
      };
    }
    if (value is List) return [for (final item in value) _canonicalize(item)];
    return value;
  }

  bool _sameCounts(Map<String, int> a, Map<String, int> b) {
    return a.length == b.length &&
        a.entries.every((entry) => b[entry.key] == entry.value);
  }

  bool _sameStrings(Set<String> a, Set<String> b) {
    return a.length == b.length && a.containsAll(b);
  }
}
