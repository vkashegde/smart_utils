import 'package:intl/intl.dart';

/// A utility class for human-readable date & time formatting.
class DateUtilsPlus {
  /// Returns human-readable time difference like '3 hours ago', 'Yesterday', 'Tomorrow'.
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
      return DateFormat('d MMM yyyy').format(dateTime);
    }
  }

  /// Returns a formatted string like 'Tomorrow 6:00 PM' or 'Yesterday 9:15 AM'.
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
      dayLabel = DateFormat('EEE, d MMM').format(dateTime);
    }

    return '$dayLabel ${DateFormat('h:mm a').format(dateTime)}';
  }

  /// Formats the date using a custom pattern.
  static String format(DateTime date, {String pattern = 'yyyy-MM-dd HH:mm'}) {
    return DateFormat(pattern).format(date);
  }

  /// Returns true if the given date is today.
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Returns true if the given date was yesterday.
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Returns the difference in human-readable string like '2d 5h 10m'.
  static String diffSummary(DateTime start, DateTime end) {
    final diff = end.difference(start);
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
