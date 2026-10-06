import 'package:flutter/services.dart';

import '../../kyc/kyc_ocr_result.dart';

class OcrService {
  static const _channel = MethodChannel('general.ocr');

  Future<KycOcrResult> extract(String imagePath) async {
    try {
      final text = await _channel.invokeMethod<String>(
            'extractText',
            {'imagePath': imagePath},
          ) ??
          '';
      return _parse(text);
    } catch (_) {
      return const KycOcrResult();
    }
  }

  KycOcrResult _parse(String rawText) {
    final lines = rawText
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    final upper = rawText.toUpperCase();

    final mrzResult = _tryParseMrz(lines);

    var issueDate =
        mrzResult.issueDate ?? _extractDateByContext(lines, _issueKeywords);
    var expiryDate =
        mrzResult.expiryDate ?? _extractDateByContext(lines, _expiryKeywords);

    // Sanity check: issue must be before expiry. If they're swapped, correct.
    if (issueDate != null && expiryDate != null) {
      final idt = _ddmmyyyyToDate(issueDate);
      final edt = _ddmmyyyyToDate(expiryDate);
      if (idt != null && edt != null && idt.isAfter(edt)) {
        final tmp = issueDate;
        issueDate = expiryDate;
        expiryDate = tmp;
      }
    }

    return KycOcrResult(
      idNumber: mrzResult.idNumber ?? _extractIdNumber(lines),
      dateOfBirth: mrzResult.dateOfBirth ??
          _extractDateByContext(lines, _dobKeywords),
      issueDate: issueDate,
      expiryDate: expiryDate,
      cardType: _detectCardType(upper),
    );
  }

  // ── MRZ parsing ─────────────────────────────────────────────────────────────

  KycOcrResult _tryParseMrz(List<String> lines) {
    final mrzLines = lines
        .where((l) {
          final clean = l.replaceAll(' ', '');
          return clean.length >= 28 &&
              RegExp(r'^[A-Z0-9<]+$').hasMatch(clean);
        })
        .map((l) => l.replaceAll(' ', ''))
        .toList();

    if (mrzLines.isEmpty) return const KycOcrResult();

    String? dob;
    String? expiry;
    String? docType;
    String? idNumber;

    for (final line in mrzLines) {
      if (line.length == 44 && line[0] == 'P') {
        docType = 'Passport';
      } else if (line.length == 30 &&
          (line[0] == 'I' || line[0] == 'A')) {
        docType = 'Identity Card';
        idNumber = _cleanMrz(line.substring(5, 14));
      }

      if (line.length == 44) {
        final d = line.substring(13, 19);
        final e = line.substring(21, 27);
        if (_validMrzDate(d)) dob = _fmtMrzDate(d, isDob: true);
        if (_validMrzDate(e)) expiry = _fmtMrzDate(e, isDob: false);
        idNumber ??= _cleanMrz(line.substring(0, 9));
      } else if (line.length == 30) {
        final d = line.substring(0, 6);
        final e = line.substring(8, 14);
        if (_validMrzDate(d)) dob = _fmtMrzDate(d, isDob: true);
        if (_validMrzDate(e)) expiry = _fmtMrzDate(e, isDob: false);
      }
    }

    return KycOcrResult(
      idNumber: idNumber,
      dateOfBirth: dob,
      expiryDate: expiry,
      cardType: docType,
    );
  }

  bool _validMrzDate(String s) {
    if (s.length != 6 || !RegExp(r'^\d{6}$').hasMatch(s)) return false;
    final month = int.parse(s.substring(2, 4));
    final day = int.parse(s.substring(4, 6));
    return month >= 1 && month <= 12 && day >= 1 && day <= 31;
  }

  String _fmtMrzDate(String yymmdd, {required bool isDob}) {
    final yy = int.parse(yymmdd.substring(0, 2));
    final mm = yymmdd.substring(2, 4);
    final dd = yymmdd.substring(4, 6);
    final now = DateTime.now().year % 100;
    final year = isDob
        ? (yy > now ? 1900 + yy : 2000 + yy)
        : (yy < now ? 2100 + yy : 2000 + yy);
    return '$dd/$mm/$year';
  }

  String? _cleanMrz(String s) {
    final c = s.replaceAll('<', '').trim();
    return c.isEmpty ? null : c;
  }

  // ── ID number extraction ─────────────────────────────────────────────────────

  static final _uaeIdPattern =
      RegExp(r'\b784[-\s]?\d{4}[-\s]?\d{7}[-\s]?\d\b');
  static final _keywordIdPattern = RegExp(
    r'(?:ID\s*(?:NO\.?|NUMBER|#|:)|NO\.?\s*:?)\s*([A-Z0-9][-A-Z0-9\s]{5,17})',
    caseSensitive: false,
  );

  String? _extractIdNumber(List<String> lines) {
    for (final line in lines) {
      final uae = _uaeIdPattern.firstMatch(line);
      if (uae != null) return uae.group(0);
    }
    for (final line in lines) {
      final kw = _keywordIdPattern.firstMatch(line);
      if (kw != null) return kw.group(1)?.trim();
    }
    return null;
  }

  // ── Date extraction by context keywords ────────────────────────────────────

  static const _dobKeywords = [
    'DOB',
    'DATE OF BIRTH',
    'BIRTH DATE',
    'BIRTHDATE',
    'BORN',
    'DATE NAISSANCE',
  ];
  static const _issueKeywords = [
    'ISSUE DATE',
    'DATE OF ISSUE',
    'ISSUED ON',
    'DATE ISSUED',
    'VALID FROM',
    'DATE ISSUE',
  ];
  static const _expiryKeywords = [
    'EXPIRY DATE',
    'DATE OF EXPIRY',
    'EXPIRY',
    'EXPIRATION',
    'EXPIRES',
    'VALID UNTIL',
    'VALID THRU',
    'EXP',
    'VALIDITY',
  ];

  static final _dateNumRx =
      RegExp(r'\b(\d{1,2})[/\-\.](\d{1,2})[/\-\.](\d{2,4})\b');
  static final _dateDmyRx = RegExp(
    r'\b(\d{1,2})\s+(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)\s+(\d{2,4})\b',
    caseSensitive: false,
  );
  static final _dateMdyRx = RegExp(
    r'\b(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)\s+(\d{1,2}),?\s+(\d{4})\b',
    caseSensitive: false,
  );

  String? _extractDateByContext(List<String> lines, List<String> keywords) {
    for (var i = 0; i < lines.length; i++) {
      final upper = lines[i].toUpperCase();
      for (final kw in keywords) {
        if (!upper.contains(kw)) continue;
        final kwPos = upper.indexOf(kw);
        for (final src in [lines[i], if (i + 1 < lines.length) lines[i + 1]]) {
          final d = _parseDateNearest(src, kwPos);
          if (d != null) return d;
        }
        break;
      }
    }
    return null;
  }

  String? _parseDateNearest(String src, int refPos) {
    final allMatches = <(int, String)>[];
    for (final rx in [_dateNumRx, _dateDmyRx, _dateMdyRx]) {
      for (final m in rx.allMatches(src)) {
        final d = _parseDate(src.substring(m.start, m.end));
        if (d != null) allMatches.add((m.start, d));
      }
    }
    if (allMatches.isEmpty) return null;
    allMatches.sort(
        (a, b) => (a.$1 - refPos).abs().compareTo((b.$1 - refPos).abs()));
    return allMatches.first.$2;
  }

  String? _parseDate(String src) {
    final n = _dateNumRx.firstMatch(src);
    if (n != null) {
      final p1 = n.group(1)!;
      final p2 = n.group(2)!;
      final raw3 = n.group(3)!;
      final year = raw3.length == 2
          ? (int.parse(raw3) > 50 ? '19$raw3' : '20$raw3')
          : raw3;
      return '${p1.padLeft(2, '0')}/${p2.padLeft(2, '0')}/$year';
    }
    final dmy = _dateDmyRx.firstMatch(src);
    if (dmy != null) {
      final day = dmy.group(1)!;
      final mon = _monthNum(dmy.group(2)!);
      final year = dmy.group(3)!;
      return '${day.padLeft(2, '0')}/${mon.toString().padLeft(2, '0')}/$year';
    }
    final mdy = _dateMdyRx.firstMatch(src);
    if (mdy != null) {
      final mon = _monthNum(mdy.group(1)!);
      final day = mdy.group(2)!;
      final year = mdy.group(3)!;
      return '${day.padLeft(2, '0')}/${mon.toString().padLeft(2, '0')}/$year';
    }
    return null;
  }

  int _monthNum(String name) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
    ];
    return months.indexOf(name.toUpperCase().substring(0, 3)) + 1;
  }

  DateTime? _ddmmyyyyToDate(String s) {
    final parts = s.split('/');
    if (parts.length != 3) return null;
    try {
      return DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    } catch (_) {
      return null;
    }
  }

  // ── Card type detection ──────────────────────────────────────────────────────

  String? _detectCardType(String upper) {
    if (upper.contains('PASSPORT')) return 'Passport';
    if (upper.contains('IDENTITY CARD') ||
        upper.contains('ID CARD') ||
        upper.contains('NATIONAL ID')) {
      return 'Identity Card';
    }
    if (upper.contains('DRIVING') || upper.contains('DRIVER')) {
      return 'Driving License';
    }
    if (upper.contains('RESIDENCE') ||
        upper.contains('IQAMA') ||
        upper.contains('RESIDENCY')) {
      return 'Residence Permit';
    }
    if (upper.contains('VISA')) return 'Visa';
    return null;
  }
}