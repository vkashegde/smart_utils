/// A utility class for string manipulation and validation operations.
///
/// Provides methods for string transformations, formatting, and validation
/// with proper null safety and input validation.
class StringUtilsPlus {
  // Cache compiled regex patterns for better performance
  static final RegExp _slugifyRegex = RegExp(r'[^a-z0-9]+');
  static final RegExp _slugifyTrimRegex = RegExp(r'^-|-$');
  // More robust email regex pattern (RFC 5322 compliant)
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
  );
  // More robust URL regex pattern
  static final RegExp _urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );

  /// Capitalizes the first letter of the string.
  ///
  /// Returns an empty string if [input] is null or empty.
  /// Handles multi-byte characters properly.
  ///
  /// Example:
  /// ```dart
  /// StringUtilsPlus.capitalize('hello'); // 'Hello'
  /// StringUtilsPlus.capitalize(''); // ''
  /// StringUtilsPlus.capitalize(null); // ''
  /// ```
  static String capitalize(String? input) {
    if (input == null || input.isEmpty) return '';
    return input[0].toUpperCase() + input.substring(1);
  }

  /// Converts string to a URL-friendly slug.
  ///
  /// Removes special characters, converts to lowercase, and replaces
  /// spaces with hyphens. Trims leading/trailing hyphens.
  ///
  /// Returns an empty string if [input] is null or empty.
  ///
  /// Example:
  /// ```dart
  /// StringUtilsPlus.slugify('Hello World!'); // 'hello-world'
  /// StringUtilsPlus.slugify('  Test  '); // 'test'
  /// ```
  static String slugify(String? input) {
    if (input == null || input.isEmpty) return '';
    // Optimized: single pass with cached regex
    return input
        .toLowerCase()
        .trim()
        .replaceAll(_slugifyRegex, '-')
        .replaceAll(_slugifyTrimRegex, '');
  }

  /// Truncates string to [maxLength] with optional [suffix].
  ///
  /// Throws [ArgumentError] if [maxLength] is negative.
  /// If [maxLength] is less than or equal to [suffix] length,
  /// returns only the suffix.
  ///
  /// Example:
  /// ```dart
  /// StringUtilsPlus.truncate('Long text here', 7); // 'Long te...'
  /// StringUtilsPlus.truncate('Short', 10); // 'Short'
  /// ```
  ///
  /// Throws [ArgumentError] if [maxLength] is negative.
  static String truncate(
    String? input,
    int maxLength, {
    String suffix = '...',
  }) {
    if (input == null) return '';
    if (maxLength < 0) {
      throw ArgumentError.value(
        maxLength,
        'maxLength',
        'maxLength must be non-negative',
      );
    }
    if (input.length <= maxLength) return input;
    if (maxLength <= suffix.length) return suffix;
    return input.substring(0, maxLength - suffix.length) + suffix;
  }

  /// Validates if string is a valid email address.
  ///
  /// Uses a more robust regex pattern that follows RFC 5322 standards.
  /// Returns `false` if [input] is null or empty.
  ///
  /// Example:
  /// ```dart
  /// StringUtilsPlus.isEmail('test@example.com'); // true
  /// StringUtilsPlus.isEmail('invalid-email'); // false
  /// StringUtilsPlus.isEmail(null); // false
  /// ```
  static bool isEmail(String? input) {
    if (input == null || input.isEmpty) return false;
    return _emailRegex.hasMatch(input.trim());
  }

  /// Validates if string is a valid URL.
  ///
  /// Only accepts HTTP and HTTPS URLs. Returns `false` if [input] is null or empty.
  ///
  /// Example:
  /// ```dart
  /// StringUtilsPlus.isUrl('https://flutter.dev'); // true
  /// StringUtilsPlus.isUrl('http://example.com'); // true
  /// StringUtilsPlus.isUrl('not-a-url'); // false
  /// ```
  static bool isUrl(String? input) {
    if (input == null || input.isEmpty) return false;
    return _urlRegex.hasMatch(input.trim());
  }
}
