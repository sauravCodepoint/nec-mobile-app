import 'package:flutter/widgets.dart';

import '../theme/app_theme_ext.dart';

/// A [TextEditingController] that owns a fixed-length digit mask.
///
/// - Unfilled slots show [maskChar] (`'X'` by default).
/// - Non-digit characters in any input are silently discarded.
/// - The cursor is always locked at the end of the typed digits, regardless
///   of where the user taps — so it always "starts from the first position"
///   when the field is empty.
/// - [rawValue] gives the clean digit string (no mask characters).
/// - Call [resetMask] when the mask length must change at runtime
///   (e.g. a different ID type is selected).
class MaskedDigitController extends TextEditingController {
  int _maskLength;
  final String maskChar;

  MaskedDigitController({required int maskLength, this.maskChar = 'X'})
    : _maskLength = maskLength,
      // Bypass our own override during construction.
      super(text: maskChar * maskLength);

  /// Digits typed by the user, with mask characters stripped.
  String get rawValue => text.replaceAll(maskChar, '');

  /// Resets to a new [newLength] and clears any typed input.
  void resetMask(int newLength) {
    _maskLength = newLength;
    // Use super.value to bypass our override — this is a programmatic reset.
    super.value = newLength > 0
        ? TextEditingValue(
            text: maskChar * newLength,
            selection: TextSelection.collapsed(offset: 0),
          )
        : TextEditingValue.empty;
  }

  // ── Text transformation ──────────────────────────────────────────────────

  @override
  set value(TextEditingValue newValue) {
    if (_maskLength == 0) {
      super.value = newValue;
      return;
    }
    // Extract only western digits, up to maskLength.
    final digits = StringBuffer();
    for (final ch in newValue.text.split('')) {
      if (digits.length == _maskLength) break;
      if (ch.codeUnitAt(0) >= 48 && ch.codeUnitAt(0) <= 57) digits.write(ch);
    }
    final filled = digits.toString();
    super.value = TextEditingValue(
      text: filled.padRight(_maskLength, maskChar),
      selection: TextSelection.collapsed(offset: filled.length),
    );
  }

  // ── Rendering ────────────────────────────────────────────────────────────

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // No mask (variable-length IDs) → default rendering.
    if (_maskLength == 0) {
      return super.buildTextSpan(
        context: context,
        style: style,
        withComposing: withComposing,
      );
    }

    final filledLength = rawValue.length;
    final typed = text.substring(0, filledLength);
    final maskRemainder = text.substring(filledLength);

    // Render the unfilled mask slots in a light, muted color so the `X`
    // placeholders read as a hint rather than as entered text.
    final maskStyle = (style ?? const TextStyle()).copyWith(
      color: context.appColors.muted,
    );

    return TextSpan(
      style: style,
      children: [
        if (typed.isNotEmpty) TextSpan(text: typed, style: style),
        if (maskRemainder.isNotEmpty)
          TextSpan(text: maskRemainder, style: maskStyle),
      ],
    );
  }

  // ── Cursor lock ──────────────────────────────────────────────────────────

  @override
  set selection(TextSelection newSelection) {
    if (_maskLength == 0) {
      super.selection = newSelection;
      return;
    }
    // Lock cursor to the end of typed digits on every tap / focus event.
    super.selection = TextSelection.collapsed(offset: rawValue.length);
  }
}
