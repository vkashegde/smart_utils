import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_plus/smart_utils_plus.dart';

void main() {
  test('LoggerPlus should not throw error when logging', () {
    expect(() => LoggerPlus.info('Info log test'), returnsNormally);
    expect(() => LoggerPlus.success('Success log test'), returnsNormally);
    expect(() => LoggerPlus.warning('Warning log test'), returnsNormally);
    expect(() => LoggerPlus.error('Error log test'), returnsNormally);
    expect(() => LoggerPlus.debug('Debug log test'), returnsNormally);
  });

  test('LoggerPlus can be disabled', () {
    LoggerPlus.isEnabled = false;
    expect(() => LoggerPlus.info('Should not print'), returnsNormally);
    LoggerPlus.isEnabled = true; // reset
  });
}
