import 'package:flutter/services.dart';

/// Strips leading whitespace and collapses consecutive spaces so free-text
/// values can never start with, or hide, extra whitespace.
class AppNoExtraSpaceInputFormatter extends TextInputFormatter {
  static final RegExp _leadingSpaces = RegExp(r'^\s+');
  static final RegExp _consecutiveSpaces = RegExp(r'\s{2,}');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final sanitized = newValue.text
        .replaceFirst(_leadingSpaces, '')
        .replaceAll(_consecutiveSpaces, ' ');
    if (sanitized == newValue.text) return newValue;
    final removed = newValue.text.length - sanitized.length;
    final offset = (newValue.selection.end - removed).clamp(
      0,
      sanitized.length,
    );
    return TextEditingValue(
      text: sanitized,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}