import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';

class Remarks extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Remarks(String? input) {
    assert(input != null);
    return Remarks._(right(input!.trim()));
  }

  const Remarks._(this.value);
}