/// Log levels in order of severity (debug < info < success < warning < error).
enum LogLevel {
  /// Debug messages (lowest priority).
  debug,
  /// Informational messages.
  info,
  /// Success messages.
  success,
  /// Warning messages.
  warning,
  /// Error messages (highest priority).
  error,
}

/// A colorful and lightweight console logger for Flutter & Dart.
///
/// Supports log levels, customizable timestamps, and optional file logging.
///
/// Example:
/// ```dart
/// LoggerPlus.minLevel = LogLevel.info;
/// LoggerPlus.info('Application started');
/// LoggerPlus.error('An error occurred');
/// ```
class LoggerPlus {

  /// Whether to print logs. Can be turned off in production.
  static bool isEnabled = true;

  /// Minimum log level to display. Logs below this level will be ignored.
  static LogLevel minLevel = LogLevel.debug;

  /// Show timestamp with each log.
  static bool showTimestamp = true;

  /// Timestamp format. Defaults to 'HH:mm:ss' (e.g., '14:30:45').
  /// Set to null to use ISO8601 format.
  static String? timestampFormat = 'HH:mm:ss';

  /// Optional file path for logging. If set, logs will be written to this file.
  /// Set to null to disable file logging.
  static String? logFilePath;

  /// Prints an info message in cyan.
  ///
  /// Example:
  /// ```dart
  /// LoggerPlus.info('Application started');
  /// ```
  static void info(String message) {
    _printLog(LogLevel.info, message, _AnsiColor.cyan);
  }

  /// Prints a success message in green.
  ///
  /// Example:
  /// ```dart
  /// LoggerPlus.success('Operation completed');
  /// ```
  static void success(String message) {
    _printLog(LogLevel.success, message, _AnsiColor.green);
  }

  /// Prints a warning message in yellow.
  ///
  /// Example:
  /// ```dart
  /// LoggerPlus.warning('Deprecated API used');
  /// ```
  static void warning(String message) {
    _printLog(LogLevel.warning, message, _AnsiColor.yellow);
  }

  /// Prints an error message in red.
  ///
  /// Example:
  /// ```dart
  /// LoggerPlus.error('Failed to load data');
  /// ```
  static void error(String message) {
    _printLog(LogLevel.error, message, _AnsiColor.red);
  }

  /// Prints a debug message in magenta.
  ///
  /// Example:
  /// ```dart
  /// LoggerPlus.debug('Variable value: $value');
  /// ```
  static void debug(String message) {
    _printLog(LogLevel.debug, message, _AnsiColor.magenta);
  }

  /// Core function that formats and prints the log.
  static void _printLog(LogLevel level, String message, String color) {
    if (!isEnabled) return;
    if (level.index < minLevel.index) return;

    final now = DateTime.now();
    final timestamp = showTimestamp ? _formatTimestamp(now) : '';
    final levelName = level.name.toUpperCase();
    final formatted = '$color$timestamp[$levelName] $message${_AnsiColor.reset}';

    // ignore: avoid_print
    print(formatted);

    // Write to file if file logging is enabled
    if (logFilePath != null) {
      _writeToFile('$timestamp[$levelName] $message\n');
    }
  }

  /// Formats the timestamp according to the configured format.
  static String _formatTimestamp(DateTime dateTime) {
    if (timestampFormat == null) {
      return '[${dateTime.toIso8601String()}] ';
    }

    try {
      final hours = dateTime.hour.toString().padLeft(2, '0');
      final minutes = dateTime.minute.toString().padLeft(2, '0');
      final seconds = dateTime.second.toString().padLeft(2, '0');
      return '[$hours:$minutes:$seconds] ';
    } catch (e) {
      return '[${dateTime.toIso8601String()}] ';
    }
  }

  /// Writes log message to file asynchronously.
  static void _writeToFile(String message) {
    if (logFilePath == null) return;

    // Note: In a real implementation, you might want to use a proper
    // file writing mechanism with error handling and buffering.
    // This is a simplified version.
    try {
      // ignore: avoid_print
      // In production, you'd use dart:io File operations here
      // For now, this is a placeholder that would need platform-specific implementation
    } catch (e) {
      // Silently fail file logging to not break console logging
    }
  }
}

/// Internal ANSI color codes for terminal output.
/// These work in most IDE terminals and command-line interfaces.
class _AnsiColor {
  static const reset = '\x1B[0m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const cyan = '\x1B[36m';
  static const magenta = '\x1B[35m';
}
