import 'package:intl/intl.dart';

class OweMeDateUtils {
  OweMeDateUtils._();

  static String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
