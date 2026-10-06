import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';
import '../core/value_validators.dart';

class DynamicFieldInput extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory DynamicFieldInput({
    required String input,
    required bool mandatory,
    int? minLength,
    int? maxLength,
    String? regexPattern,
  }) {
    return DynamicFieldInput._(
      validateDynamicInput(
        input: input,
        mandatory: mandatory,
        minLength: minLength,
        maxLength: maxLength,
        regexPattern: regexPattern,
      ),
    );
  }

  const DynamicFieldInput._(this.value);
}