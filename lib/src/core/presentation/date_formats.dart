import 'package:intl/intl.dart';

class DateFormats {
  /// Formats a date as `dd/MM/yyyy`, e.g., `12/06/2025`
  static final DateFormat ddMMyyyy = DateFormat('dd/MM/yyyy');

  /// Formats a date as `dd MMM yyyy`, e.g., `12 Jun 2025`
  static final DateFormat ddMMMyyyy = DateFormat('dd MMM yyyy');

  /// Formats a date with time as `dd/MM/yyyy HH:mm`, e.g., `12/06/2025 14:30`
  static final DateFormat ddMMyyyyHm = DateFormat('dd/MM/yyyy HH:mm');

  /// Formats time only as `HH:mm`, e.g., `14:30`
  static final DateFormat hourMinute = DateFormat('HH:mm');

  /// Formats ISO date (yyyy-MM-dd)
  static final DateFormat isoDate = DateFormat('yyyy-MM-dd');
}
