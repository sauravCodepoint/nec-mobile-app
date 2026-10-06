import 'package:flutter/widgets.dart';

extension TextEditingControllerX on TextEditingController {
  /// Replaces the text keeping the caret at the end, so programmatic writes
  /// into a currently focused field (e.g. a calculated amount landing while
  /// the user rests focus there) don't strand the cursor at the start.
  void setTextKeepCaretAtEnd(String newText) {
    if (text == newText) return;
    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}