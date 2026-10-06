extension StringFormatExtension on String {
  String toCleanUpperCase() {
    return trim().replaceAll(RegExp(r'\s+'), ' ').toUpperCase();
  }

  /// Title-cases each whitespace-separated word (first letter upper, rest
  /// lower). Handy for presenting backend names stored in upper case.
  String toTitleCase() {
    return trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}