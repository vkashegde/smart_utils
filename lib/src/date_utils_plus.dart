import 'package:intl/intl.dart';

/// A utility class for human-readable date & time formatting.
///
/// Date formatters are cached for better performance.
class DateUtilsPlus {
  // Cache DateFormat instances to avoid recreating them
  static final Map<String, DateFormat> _formatterCache = {};

  /// Gets or creates a cached DateFormat instance.
  static DateFormat _getFormatter(String pattern) {
    return _formatterCache.putIfAbsent(
      pattern,
      () => DateFormat(pattern),
    );
  }

  /// Returns human-readable time difference like '3 hours ago', 'Yesterday', 'Tomorrow'.
  ///
  /// Example:
  /// ```dart
  /// DateUtilsPlus.timeAgo(DateTime.now().subtract(Duration(hours: 3)));
  /// // Returns: "3 hours ago"
  /// ```
  static String timeAgo(DateTime dateTime, {DateTime? reference}) {
    final now = reference ?? DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return _getFormatter('d MMM yyyy').format(dateTime);
    }
  }

  /// Returns a formatted string like 'Tomorrow 6:00 PM' or 'Yesterday 9:15 AM'.
  ///
  /// Example:
  /// ```dart
  /// DateUtilsPlus.smartDateTime(DateTime.now());
  /// // Returns: "Today 6:00 PM"
  /// ```
  static String smartDateTime(DateTime dateTime, {DateTime? reference}) {
    final now = reference ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final given = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final diffDays = given.difference(today).inDays;

    String dayLabel;
    if (diffDays == 0) {
      dayLabel = 'Today';
    } else if (diffDays == -1) {
      dayLabel = 'Yesterday';
    } else if (diffDays == 1) {
      dayLabel = 'Tomorrow';
    } else {
      dayLabel = _getFormatter('EEE, d MMM').format(dateTime);
    }

    return '$dayLabel ${_getFormatter('h:mm a').format(dateTime)}';
  }

  /// Formats the date using a custom pattern.
  ///
  /// The formatter is cached for better performance when using the same pattern.
  ///
  /// Example:
  /// ```dart
  /// DateUtilsPlus.format(DateTime.now(), pattern: 'yyyy-MM-dd');
  /// // Returns: "2025-01-09"
  /// ```
  static String format(DateTime date, {String pattern = 'yyyy-MM-dd HH:mm'}) {
    return _getFormatter(pattern).format(date);
  }

  /// Returns true if the given date is today.
  ///
  /// Example:
  /// ```dart
  /// DateUtilsPlus.isToday(DateTime.now()); // true
  /// ```
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Returns true if the given date was yesterday.
  ///
  /// Example:
  /// ```dart
  /// DateUtilsPlus.isYesterday(DateTime.now().subtract(Duration(days: 1))); // true
  /// ```
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Returns the difference in human-readable string like '2d 5h 10m'.
  ///
  /// If [absolute] is true (default), returns absolute difference.
  /// If [start] is after [end], the result will be negative if [absolute] is false.
  ///
  /// Example:
  /// ```dart
  /// DateUtilsPlus.diffSummary(startDate, endDate);
  /// // Returns: "2d 5h 10m"
  /// ```
  static String diffSummary(
    DateTime start,
    DateTime end, {
    bool absolute = true,
  }) {
    var diff = end.difference(start);
    if (absolute && diff.isNegative) {
      diff = diff.abs();
    }

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    final parts = <String>[];
    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');

    return parts.isEmpty ? '0m' : parts.join(' ');
  }
}
