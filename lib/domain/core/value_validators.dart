import 'package:dartz/dartz.dart';

import 'failures.dart';

/// The only identity type this market issues. The backend's identity-type
/// list is still read at runtime (so a future type shows up without a client
/// release), but every code it currently returns is this one.
const String kIdentityTypeCode = 'CPR';

/// Upper bound on the digits of a CPR number. CPR carries no fixed length, so
/// this is a cap rather than an exact count — it exists to keep the input
/// field and the validator agreeing on what can ever be accepted.
const int kIdentityNumberMaxLength = 20;

/// Validates a CPR identity number.
///
/// [idType] is still taken so a mismatched type is caught rather than silently
/// validated: anything other than [kIdentityTypeCode] is a state/backend
/// mismatch, not user input, and is rejected outright.
Either<ValueFailure<String>, String> validateIdentityNumber(
  String input,
  String idType,
) {
  if (idType.toUpperCase() != kIdentityTypeCode) {
    return left(ValueFailure.invalidIdentityNumber(failedValue: idType));
  }

  // Digits only, non-empty (the `+` rules out an empty string) and no longer
  // than the cap.
  if (!RegExp(r'^\d+$').hasMatch(input) ||
      input.length > kIdentityNumberMaxLength) {
    return left(ValueFailure.invalidIdentityNumber(failedValue: input));
  }

  return right(input);
}

/// Validates a given mobile number string.
///
/// An Oman mobile number is 8 digits, and that length is all this check
/// enforces. It deliberately does NOT whitelist leading digits: the old
/// `[379]` prefix list came from the Bahrain-based app this one was ported
/// from, so legitimate 8-digit Oman numbers outside that set were rejected
/// before the request ever left the device. Which prefixes are actually in
/// service changes as the regulator allocates new ranges, and the backend is
/// the authority on whether a number exists — so the client only guards the
/// shape.
///
/// - Parameters:
///   - `input`: The mobile number string to validate.
/// - Returns:
///   - `Either<ValueFailure<String>, String>`: Returns the input string wrapped in `right` if valid,
///     or a `ValueFailure` wrapped in `left` if invalid.
Either<ValueFailure<String>, String> validateMobileNumber(String input) {
  final mobileRegex = RegExp(r'^\d{8}$');

  if (mobileRegex.hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidMobileNumber(failedValue: input));
  }
}

/// Validates a given OTP string.
///
/// This function checks if the input matches the OTP format using a regular expression.
/// A valid OTP must consist of exactly 4 digits.
///
/// - Parameters:
///   - `input`: The OTP string to validate.
/// - Returns:
///   - `Either<ValueFailure<String>, String>`: Returns the input string wrapped in `right` if valid,
///     or a `ValueFailure` wrapped in `left` if invalid.
Either<ValueFailure<String>, String> validateOtp(String input) {
  final otpRegex = RegExp(r'^\d{4}$'); // Exactly 4 digits

  if (otpRegex.hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidOtp(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  if (emailRegex.hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmailAddress(failedValue: input));
  }
}

/// Validates a dynamic input string based on provided criteria.
///
/// This function performs multiple checks on the input string, including:
/// 1. Mandatory check: Ensures the input is not empty if it is required.
/// 2. Length validation: Checks if the input meets the specified minimum and maximum length requirements.
/// 3. Regex validation: Validates the input against a provided regular expression pattern (if any).
/// - Parameters:
///   - `input`: The string input to validate.
///   - `mandatory`: A boolean indicating whether the input is required.
///   - `minLength`: An optional integer specifying the minimum length of the input.
///   - `maxLength`: An optional integer specifying the maximum length of the input.
///   - `regexPattern`: An optional string containing a regular expression pattern to validate the input against.
/// - Returns:
///   - `Either<ValueFailure<String>, String>`: Returns the input string wrapped in `right` if valid, or a `ValueFailure` wrapped in `left` if any validation fails
Either<ValueFailure<String>, String> validateDynamicInput({
  required String input,
  required bool mandatory,
  int? minLength,
  int? maxLength,
  String? regexPattern,
}) {
  final value = input.trim();

  /// 1️⃣ Mandatory
  if (mandatory && value.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  }

  if (value.isEmpty) {
    return right(value);
  }

  /// 2️⃣ Length validation — the backend's field settings are authoritative.
  if (minLength != null && minLength > 0 && value.length < minLength) {
    return left(
      ValueFailure.tooShort(failedValue: input, minLength: minLength),
    );
  }

  if (maxLength != null && maxLength > 0 && value.length > maxLength) {
    return left(ValueFailure.tooLong(failedValue: input, maxLength: maxLength));
  }

  /// 3️⃣ Regex validation (if provided by backend)
  if (regexPattern != null && regexPattern.isNotEmpty) {
    try {
      final regex = RegExp(regexPattern);
      if (!regex.hasMatch(value)) {
        return left(
          ValueFailure.invalidFormat(
            failedValue: input,
            regexPattern: regexPattern,
          ),
        );
      }
    } catch (_) {
      // Ignore invalid backend regex
    }
  }

  return right(value);
}

Either<ValueFailure<String>, String> validateMpin(
  String input, {
  String? currentMpin,
}) {
  final cleaned = input.trim();

  if (currentMpin != null && cleaned == currentMpin) {
    return left(ValueFailure.sameAsCurrentMpin(failedValue: input));
  }

  // Only 6 digits
  if (!RegExp(r'^\d{6}$').hasMatch(cleaned)) {
    return left(ValueFailure.invalidMpin(failedValue: input));
  }

  // No repeated digits (111111, 000000)
  if (RegExp(r'^(\d)\1{5}$').hasMatch(cleaned)) {
    return left(ValueFailure.repeatedDigits(failedValue: input));
  }

  // No sequential digits
  const sequences = ['012345', '123456', '234567', '345678', '456789'];

  const reverseSequences = ['543210', '654321', '765432', '876543', '987654'];

  if (sequences.contains(cleaned) || reverseSequences.contains(cleaned)) {
    return left(ValueFailure.sequentialDigits(failedValue: input));
  }

  return right(cleaned);
}

Either<ValueFailure<String>, String> validateNotEmpty(String input) {
  final value = input.trim();

  if (value.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  }

  return right(value);
}
