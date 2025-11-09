import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_plus/smart_utils.dart';

void main() {
  test('Platform detection should return boolean values', () {
    expect(DeviceUtilsPlus.isWeb, isA<bool>());
    expect(DeviceUtilsPlus.isMobile, isA<bool>());
  });
}
