import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils/smart_utils.dart';

void main() {
  test('timeAgo should show minutes correctly', () {
    final now = DateTime(2025, 1, 1, 12, 0);
    final past = DateTime(2025, 1, 1, 11, 45);
    expect(DateUtilsPlus.timeAgo(past, reference: now), '15 mins ago');
  });

  test('smartDateTime should show Today 6:00 PM', () {
    final date = DateTime(2025, 1, 1, 18, 0);
    final now = DateTime(2025, 1, 1, 10, 0);
    expect(DateUtilsPlus.smartDateTime(date, reference: now), 'Today 6:00 PM');
  });

  test('isToday should detect today', () {
    final today = DateTime.now();
    expect(DateUtilsPlus.isToday(today), true);
  });

  test('diffSummary should show 2d 5h 10m', () {
    final start = DateTime(2025, 1, 1, 10, 0);
    final end = DateTime(2025, 1, 3, 15, 10);
    expect(DateUtilsPlus.diffSummary(start, end), '2d 5h 10m');
  });
}
