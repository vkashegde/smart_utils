import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_plus/smart_utils_plus.dart';

void main() {
  group('formatCurrency', () {
    test('should format currency with default symbol and decimals', () {
      expect(NumberUtilsPlus.formatCurrency(1234.56), '\$1,234.56');
      expect(NumberUtilsPlus.formatCurrency(1000), '\$1,000.00');
      expect(NumberUtilsPlus.formatCurrency(0), '\$0.00');
    });

    test('should format currency with custom symbol', () {
      expect(NumberUtilsPlus.formatCurrency(1234.56, symbol: '€'), '€1,234.56');
      expect(NumberUtilsPlus.formatCurrency(1000, symbol: '£'), '£1,000.00');
    });

    test('should format currency with custom decimal places', () {
      expect(NumberUtilsPlus.formatCurrency(1234.567, decimals: 0), '\$1,235');
      expect(NumberUtilsPlus.formatCurrency(1234.567, decimals: 1), '\$1,234.6');
      expect(NumberUtilsPlus.formatCurrency(1234.567, decimals: 3), '\$1,234.567');
    });

    test('should handle large numbers with thousand separators', () {
      expect(NumberUtilsPlus.formatCurrency(1234567.89), '\$1,234,567.89');
      expect(NumberUtilsPlus.formatCurrency(1000000), '\$1,000,000.00');
    });

    test('should handle negative numbers', () {
      expect(NumberUtilsPlus.formatCurrency(-1234.56), '\$-1,234.56');
      expect(NumberUtilsPlus.formatCurrency(-1000), '\$-1,000.00');
    });

    test('should throw ArgumentError for negative decimals', () {
      expect(
        () => NumberUtilsPlus.formatCurrency(100, decimals: -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('formatCompact', () {
    test('should format numbers less than 1000', () {
      expect(NumberUtilsPlus.formatCompact(0), '0');
      expect(NumberUtilsPlus.formatCompact(100), '100');
      expect(NumberUtilsPlus.formatCompact(999), '999');
      expect(NumberUtilsPlus.formatCompact(123.45), '123.5');
    });

    test('should format numbers in thousands (K)', () {
      expect(NumberUtilsPlus.formatCompact(1000), '1.0K');
      expect(NumberUtilsPlus.formatCompact(1200), '1.2K');
      expect(NumberUtilsPlus.formatCompact(999999), '1000.0K');
    });

    test('should format numbers in millions (M)', () {
      expect(NumberUtilsPlus.formatCompact(1000000), '1.0M');
      expect(NumberUtilsPlus.formatCompact(1500000), '1.5M');
      expect(NumberUtilsPlus.formatCompact(999999999), '1000.0M');
    });

    test('should format numbers in billions (B)', () {
      expect(NumberUtilsPlus.formatCompact(1000000000), '1.0B');
      expect(NumberUtilsPlus.formatCompact(2300000000), '2.3B');
    });

    test('should format numbers in trillions (T)', () {
      expect(NumberUtilsPlus.formatCompact(1000000000000), '1.0T');
      expect(NumberUtilsPlus.formatCompact(2500000000000), '2.5T');
    });

    test('should handle negative numbers', () {
      expect(NumberUtilsPlus.formatCompact(-1000), '-1.0K');
      expect(NumberUtilsPlus.formatCompact(-1500000), '-1.5M');
    });
  });

  group('formatPercentage', () {
    test('should format percentage with default decimals', () {
      expect(NumberUtilsPlus.formatPercentage(0.1234), '12.3%');
      expect(NumberUtilsPlus.formatPercentage(0.5), '50.0%');
      expect(NumberUtilsPlus.formatPercentage(1.0), '100.0%');
      expect(NumberUtilsPlus.formatPercentage(0), '0.0%');
    });

    test('should format percentage with custom decimal places', () {
      expect(NumberUtilsPlus.formatPercentage(0.1234, decimals: 0), '12%');
      expect(NumberUtilsPlus.formatPercentage(0.1234, decimals: 2), '12.34%');
      expect(NumberUtilsPlus.formatPercentage(0.5, decimals: 0), '50%');
    });

    test('should handle values greater than 1', () {
      expect(NumberUtilsPlus.formatPercentage(1.5), '150.0%');
      expect(NumberUtilsPlus.formatPercentage(2.0), '200.0%');
    });

    test('should handle negative values', () {
      expect(NumberUtilsPlus.formatPercentage(-0.5), '-50.0%');
      expect(NumberUtilsPlus.formatPercentage(-1.0), '-100.0%');
    });

    test('should throw ArgumentError for negative decimals', () {
      expect(
        () => NumberUtilsPlus.formatPercentage(0.5, decimals: -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('randomInt', () {
    test('should generate random integer within range', () {
      for (int i = 0; i < 100; i++) {
        final result = NumberUtilsPlus.randomInt(1, 10);
        expect(result, greaterThanOrEqualTo(1));
        expect(result, lessThanOrEqualTo(10));
      }
    });

    test('should handle single value range', () {
      expect(NumberUtilsPlus.randomInt(5, 5), 5);
    });

    test('should handle negative ranges', () {
      for (int i = 0; i < 50; i++) {
        final result = NumberUtilsPlus.randomInt(-10, -1);
        expect(result, greaterThanOrEqualTo(-10));
        expect(result, lessThanOrEqualTo(-1));
      }
    });

    test('should throw ArgumentError when min > max', () {
      expect(
        () => NumberUtilsPlus.randomInt(10, 1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('randomDouble', () {
    test('should generate random double within range', () {
      for (int i = 0; i < 100; i++) {
        final result = NumberUtilsPlus.randomDouble(0.0, 1.0);
        expect(result, greaterThanOrEqualTo(0.0));
        expect(result, lessThan(1.0));
      }
    });

    test('should handle negative ranges', () {
      for (int i = 0; i < 50; i++) {
        final result = NumberUtilsPlus.randomDouble(-10.0, -1.0);
        expect(result, greaterThanOrEqualTo(-10.0));
        expect(result, lessThan(-1.0));
      }
    });

    test('should handle large ranges', () {
      for (int i = 0; i < 50; i++) {
        final result = NumberUtilsPlus.randomDouble(100.0, 200.0);
        expect(result, greaterThanOrEqualTo(100.0));
        expect(result, lessThan(200.0));
      }
    });

    test('should throw ArgumentError when min >= max', () {
      expect(
        () => NumberUtilsPlus.randomDouble(10.0, 1.0),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => NumberUtilsPlus.randomDouble(5.0, 5.0),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('roundTo', () {
    test('should round to specified decimal places', () {
      expect(NumberUtilsPlus.roundTo(3.14159, 2), 3.14);
      expect(NumberUtilsPlus.roundTo(3.145, 2), 3.15);
      expect(NumberUtilsPlus.roundTo(3.14159, 3), 3.142);
    });

    test('should round to zero decimal places', () {
      expect(NumberUtilsPlus.roundTo(3.5, 0), 4.0);
      expect(NumberUtilsPlus.roundTo(3.4, 0), 3.0);
      expect(NumberUtilsPlus.roundTo(3.6, 0), 4.0);
    });

    test('should handle negative numbers', () {
      expect(NumberUtilsPlus.roundTo(-3.14159, 2), -3.14);
      expect(NumberUtilsPlus.roundTo(-3.145, 2), -3.15);
    });

    test('should handle zero', () {
      expect(NumberUtilsPlus.roundTo(0, 2), 0.0);
      expect(NumberUtilsPlus.roundTo(0.0, 5), 0.0);
    });

    test('should throw ArgumentError for negative decimals', () {
      expect(
        () => NumberUtilsPlus.roundTo(3.14, -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('floorTo', () {
    test('should floor to specified decimal places', () {
      expect(NumberUtilsPlus.floorTo(3.14159, 2), 3.14);
      expect(NumberUtilsPlus.floorTo(3.145, 2), 3.14);
      expect(NumberUtilsPlus.floorTo(3.149, 2), 3.14);
    });

    test('should floor to zero decimal places', () {
      expect(NumberUtilsPlus.floorTo(3.9, 0), 3.0);
      expect(NumberUtilsPlus.floorTo(3.1, 0), 3.0);
    });

    test('should handle negative numbers', () {
      expect(NumberUtilsPlus.floorTo(-3.14159, 2), -3.15);
      expect(NumberUtilsPlus.floorTo(-3.145, 2), -3.15);
    });

    test('should handle zero', () {
      expect(NumberUtilsPlus.floorTo(0, 2), 0.0);
      expect(NumberUtilsPlus.floorTo(0.0, 5), 0.0);
    });

    test('should throw ArgumentError for negative decimals', () {
      expect(
        () => NumberUtilsPlus.floorTo(3.14, -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('ceilTo', () {
    test('should ceil to specified decimal places', () {
      expect(NumberUtilsPlus.ceilTo(3.14159, 2), 3.15);
      expect(NumberUtilsPlus.ceilTo(3.145, 2), 3.15);
      expect(NumberUtilsPlus.ceilTo(3.14001, 2), 3.15);
    });

    test('should ceil to zero decimal places', () {
      expect(NumberUtilsPlus.ceilTo(3.1, 0), 4.0);
      expect(NumberUtilsPlus.ceilTo(3.9, 0), 4.0);
      expect(NumberUtilsPlus.ceilTo(3.0, 0), 3.0);
    });

    test('should handle negative numbers', () {
      expect(NumberUtilsPlus.ceilTo(-3.14159, 2), -3.14);
      expect(NumberUtilsPlus.ceilTo(-3.145, 2), -3.14);
    });

    test('should handle zero', () {
      expect(NumberUtilsPlus.ceilTo(0, 2), 0.0);
      expect(NumberUtilsPlus.ceilTo(0.0, 5), 0.0);
    });

    test('should throw ArgumentError for negative decimals', () {
      expect(
        () => NumberUtilsPlus.ceilTo(3.14, -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}

