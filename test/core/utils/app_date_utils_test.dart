import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/core/utils/app_date_utils.dart';

void main() {
  group('AppDateUtils.getFormattedDate', () {
    test('returns correctly formatted date with two-digit day and month', () {
      final date = DateTime(2025, 1, 2); // Jan 2, 2025
      final formatted = AppDateUtils.getFormattedDate(date);

      expect(formatted, '02/01/2025');
    });

    test('works with double-digit day and month', () {
      final date = DateTime(2025, 12, 25); // Dec 25, 2025
      final formatted = AppDateUtils.getFormattedDate(date);

      expect(formatted, '25/12/2025');
    });
  });
}
