import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_plus/smart_utils.dart';

void main() {
  test('capitalize should make first letter uppercase', () {
    expect(StringUtilsPlus.capitalize('hello'), 'Hello');
  });

  test('slugify should convert string to URL-friendly', () {
    expect(StringUtilsPlus.slugify('Hello World!'), 'hello-world');
  });

  test('truncate should shorten string correctly', () {
    expect(StringUtilsPlus.truncate('Flutter is awesome', 7), 'Flutter...');
  });

  test('isEmail should validate email', () {
    expect(StringUtilsPlus.isEmail('test@example.com'), true);
  });

  test('isUrl should validate URL', () {
    expect(StringUtilsPlus.isUrl('https://flutter.dev'), true);
  });
}
