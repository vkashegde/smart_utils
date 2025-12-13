import 'dart:math';

/// A utility class for number formatting and manipulation operations.
///
/// Provides methods for currency formatting, compact numbers, percentages,
/// random number generation, and rounding operations.
class NumberUtilsPlus {
  /// Formats a number as currency with symbol and decimal places.
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.formatCurrency(1234.56); // "\$1,234.56"
  /// NumberUtilsPlus.formatCurrency(1234.56, symbol: '€', decimals: 0); // "€1,235"
  /// ```
  static String formatCurrency(
    double amount, {
    String symbol = '\$',
    int decimals = 2,
  }) {
    if (decimals < 0) {
      throw ArgumentError.value(decimals, 'decimals', 'must be non-negative');
    }

    final rounded = roundTo(amount, decimals);
    final parts = rounded.toStringAsFixed(decimals).split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';

    // Add thousand separators
    final buffer = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
    }

    if (decimals > 0 && decimalPart.isNotEmpty) {
      return '$symbol${buffer.toString()}.$decimalPart';
    }
    return '$symbol${buffer.toString()}';
  }

  /// Formats a number in compact notation (e.g., 1.2K, 1.5M, 2.3B).
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.formatCompact(1200); // "1.2K"
  /// NumberUtilsPlus.formatCompact(1500000); // "1.5M"
  /// NumberUtilsPlus.formatCompact(2300000000); // "2.3B"
  /// ```
  static String formatCompact(double number) {
    if (number.abs() < 1000) {
      return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1);
    } else if (number.abs() < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else if (number.abs() < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number.abs() < 1000000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else {
      return '${(number / 1000000000000).toStringAsFixed(1)}T';
    }
  }

  /// Formats a number as a percentage.
  ///
  /// [value] should be between 0 and 1 for proper percentage display,
  /// but any number is accepted.
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.formatPercentage(0.1234); // "12.3%"
  /// NumberUtilsPlus.formatPercentage(0.5, decimals: 0); // "50%"
  /// ```
  static String formatPercentage(
    double value, {
    int decimals = 1,
  }) {
    if (decimals < 0) {
      throw ArgumentError.value(decimals, 'decimals', 'must be non-negative');
    }

    final percentage = value * 100;
    final rounded = roundTo(percentage, decimals);
    return '${rounded.toStringAsFixed(decimals)}%';
  }

  /// Generates a random integer between [min] and [max] (inclusive).
  ///
  /// Throws [ArgumentError] if [min] is greater than [max].
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.randomInt(1, 10); // Random number between 1 and 10
  /// ```
  static int randomInt(int min, int max) {
    if (min > max) {
      throw ArgumentError.value(
        min,
        'min',
        'must be less than or equal to max',
      );
    }
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  /// Generates a random double between [min] (inclusive) and [max] (exclusive).
  ///
  /// Throws [ArgumentError] if [min] is greater than or equal to [max].
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.randomDouble(0.0, 1.0); // Random number between 0.0 and 1.0
  /// ```
  static double randomDouble(double min, double max) {
    if (min >= max) {
      throw ArgumentError.value(
        min,
        'min',
        'must be less than max',
      );
    }
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  /// Rounds a number to the specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.roundTo(3.14159, 2); // 3.14
  /// NumberUtilsPlus.roundTo(3.145, 2); // 3.15
  /// ```
  static double roundTo(double value, int decimals) {
    if (decimals < 0) {
      throw ArgumentError.value(decimals, 'decimals', 'must be non-negative');
    }
    final factor = pow(10, decimals).toDouble();
    return (value * factor).round() / factor;
  }

  /// Floors a number to the specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.floorTo(3.14159, 2); // 3.14
  /// NumberUtilsPlus.floorTo(3.145, 2); // 3.14
  /// ```
  static double floorTo(double value, int decimals) {
    if (decimals < 0) {
      throw ArgumentError.value(decimals, 'decimals', 'must be non-negative');
    }
    final factor = pow(10, decimals).toDouble();
    return (value * factor).floor() / factor;
  }

  /// Ceils a number to the specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// NumberUtilsPlus.ceilTo(3.14159, 2); // 3.15
  /// NumberUtilsPlus.ceilTo(3.145, 2); // 3.15
  /// ```
  static double ceilTo(double value, int decimals) {
    if (decimals < 0) {
      throw ArgumentError.value(decimals, 'decimals', 'must be non-negative');
    }
    final factor = pow(10, decimals).toDouble();
    return (value * factor).ceil() / factor;
  }
}

