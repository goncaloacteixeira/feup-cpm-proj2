import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Utils {
  static toHourFormat(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static formatTemperature(num temperature) {
    return "${temperature.toStringAsFixed(0)}\u00B0";
  }

  static Future<String> formatDate(DateTime dateTime) async {
    await initializeDateFormatting('pt_PT', null);
    final DateFormat formatter = DateFormat.MMMMd("pt_PT");
    return formatter.format(dateTime);
  }
}