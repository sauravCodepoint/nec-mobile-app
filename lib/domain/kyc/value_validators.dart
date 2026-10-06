import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';
import '../core/value_validators.dart' as core;

// ── Value objects ──────────────────────────────────────────────────────────────

class IdentityNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  /// [idTypeCode] must be 'CPR' — the only identity type the backend issues.
  factory IdentityNumber(String? input, String idTypeCode) {
    assert(input != null);
    return IdentityNumber._(core.validateIdentityNumber(input!, idTypeCode));
  }

  const IdentityNumber._(this.value);
}

class IssueDate extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory IssueDate(String? input) {
    assert(input != null);
    return IssueDate._(_validateIssueDate(input!));
  }

  const IssueDate._(this.value);
}

class ExpiryDate extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory ExpiryDate(String? input) {
    assert(input != null);
    return ExpiryDate._(_validateExpiryDate(input!));
  }

  const ExpiryDate._(this.value);
}

class DateOfBirth extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory DateOfBirth(String? input) {
    assert(input != null);
    return DateOfBirth._(_validateDateOfBirth(input!));
  }

  const DateOfBirth._(this.value);
}

// ── Validators ─────────────────────────────────────────────────────────────────

DateTime? _parseDate(String input) {
  final trimmed = input.trim();
  if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(trimmed)) return null;
  try {
    final p = trimmed.split('/');
    final day = int.parse(p[0]);
    final month = int.parse(p[1]);
    final year = int.parse(p[2]);
    final dt = DateTime(year, month, day);
    if (dt.day != day || dt.month != month || dt.year != year) return null;
    return dt;
  } catch (_) {
    return null;
  }
}

Either<ValueFailure<String>, String> _validateIssueDate(String input) {
  final v = input.trim();
  if (v.isEmpty) return left(ValueFailure.empty(failedValue: input));
  final date = _parseDate(v);
  if (date == null) return left(ValueFailure.invalidDate(failedValue: input));
  if (date.isAfter(DateTime.now())) {
    return left(ValueFailure.futureDate(failedValue: input));
  }
  return right(v);
}

Either<ValueFailure<String>, String> _validateExpiryDate(String input) {
  final v = input.trim();
  if (v.isEmpty) return left(ValueFailure.empty(failedValue: input));
  final date = _parseDate(v);
  if (date == null) return left(ValueFailure.invalidDate(failedValue: input));
  if (!date.isAfter(DateTime.now())) {
    return left(ValueFailure.expiredDocument(failedValue: input));
  }
  return right(v);
}

Either<ValueFailure<String>, String> _validateDateOfBirth(String input) {
  final v = input.trim();
  if (v.isEmpty) return left(ValueFailure.empty(failedValue: input));
  final date = _parseDate(v);
  if (date == null) return left(ValueFailure.invalidDate(failedValue: input));
  final now = DateTime.now();
  if (date.isAfter(now)) {
    return left(ValueFailure.futureDate(failedValue: input));
  }
  final age = now.year -
      date.year -
      ((now.month < date.month ||
              (now.month == date.month && now.day < date.day))
          ? 1
          : 0);
  if (age < 18) {
    return left(ValueFailure.underage(failedValue: input, minAge: 18));
  }
  return right(v);
}