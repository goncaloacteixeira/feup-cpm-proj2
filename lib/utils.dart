import 'package:intl/intl.dart';

class Utils {
  static toHourFormat(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}