// lib/src/string_utils_plus.dart
class StringUtilsPlus {
  /// Capitalizes the first letter of the string.
  static String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  /// Converts string to a URL-friendly slug.
  static String slugify(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  /// Truncates string to [maxLength] with optional [suffix].
  static String truncate(String input, int maxLength, {String suffix = '...'}) {
    if (input.length <= maxLength) return input;
    return input.substring(0, maxLength) + suffix;
  }

  /// Validates if string is a valid email.
  static bool isEmail(String input) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(input);
  }

  /// Validates if string is a valid URL.
  static bool isUrl(String input) {
    final regex = RegExp(r'^(https?:\/\/)?([\w-]+(\.[\w-]+)+)([\/\w .-]*)*\/?$');
    return regex.hasMatch(input);
  }
}
