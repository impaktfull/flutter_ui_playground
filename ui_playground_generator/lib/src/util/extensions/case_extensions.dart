extension CaseExtension on String {
  /// Converts a camelCase or PascalCase string to Title Case with spaces.
  ///
  /// Example:
  /// - "myButton" -> "My Button"
  /// - "backgroundColor" -> "Background Color"
  /// - "firstName" -> "First Name"
  String toTitleCase() {
    if (isEmpty) return this;
    final formatted = replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]'),
      (match) => ' ${match.group(0)}',
    );
    return formatted[0].toUpperCase() + formatted.substring(1);
  }
}
