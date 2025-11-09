// lib/src/logger_plus.dart

/// A colorful and lightweight console logger for Flutter & Dart.
class LoggerPlus {
  /// Whether to print logs. Can be turned off in production.
  static bool isEnabled = true;

  /// Show timestamp with each log.
  static bool showTimestamp = true;

  /// Prints an info message in cyan.
  static void info(String message) {
    _printLog('INFO', message, _AnsiColor.cyan);
  }

  /// Prints a success message in green.
  static void success(String message) {
    _printLog('SUCCESS', message, _AnsiColor.green);
  }

  /// Prints a warning message in yellow.
  static void warning(String message) {
    _printLog('WARNING', message, _AnsiColor.yellow);
  }

  /// Prints an error message in red.
  static void error(String message) {
    _printLog('ERROR', message, _AnsiColor.red);
  }

  /// Prints a debug message in magenta.
  static void debug(String message) {
    _printLog('DEBUG', message, _AnsiColor.magenta);
  }

  /// Core function that formats and prints the log.
  static void _printLog(String level, String message, String color) {
    if (!isEnabled) return;

    final timestamp = showTimestamp ? '[${DateTime.now().toIso8601String()}] ' : '';
    final formatted = '$color$timestamp[$level] $message${_AnsiColor.reset}';
    // ignore: avoid_print
    print(formatted);
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
