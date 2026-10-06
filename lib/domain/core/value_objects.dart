import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'error.dart';
import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  // id = identity - same as writing (right) => right;
  T getOrCrash() => value.fold(
        (failure) => throw UnExpectedValueError(failure),
    id,
  );

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit => value.fold(
        (failure) => left(failure),
        (_) => right(unit),
  );

  bool isValid() => value.isRight();

  @override
  bool operator ==(covariant ValueObject<T> other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value(value: $value)';
}

// Returns the raw input whether the value is valid or failed.
// Works because every ValueFailure case declares a `failedValue` field.
extension ValueObjectString on ValueObject<String> {
  String get rawValue => value.fold((f) => f.failedValue, (v) => v);
}
