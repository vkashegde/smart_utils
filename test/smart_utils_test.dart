import 'package:flutter_test/flutter_test.dart';

import 'package:smart_utils_plus/smart_utils_plus.dart';

void main() {
  test('all utility classes are properly exported', () {
    // Verify DateUtilsPlus is exported
    expect(DateUtilsPlus.timeAgo, isA<Function>());

    // Verify StringUtilsPlus is exported
    expect(StringUtilsPlus.capitalize, isA<Function>());

    // Verify DeviceUtilsPlus is exported
    expect(DeviceUtilsPlus.isWeb, isA<bool>());

    // Verify WidgetUtilsPlus is exported
    expect(WidgetUtilsPlus.showSnackbar, isA<Function>());

    // Verify LoggerPlus is exported
    expect(LoggerPlus.info, isA<Function>());
  });

  test('DateUtilsPlus formats dates correctly', () {
    final now = DateTime(2025, 1, 1, 12, 0);
    final past = DateTime(2025, 1, 1, 11, 45);
    expect(DateUtilsPlus.timeAgo(past, reference: now), '15 mins ago');
  });

  test('StringUtilsPlus capitalizes strings correctly', () {
    expect(StringUtilsPlus.capitalize('hello'), 'Hello');
    expect(StringUtilsPlus.capitalize(''), '');
  });
}
