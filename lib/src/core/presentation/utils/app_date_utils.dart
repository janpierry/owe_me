import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
