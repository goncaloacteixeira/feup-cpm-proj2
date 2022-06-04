import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class Utils {
  static toHourFormat(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm');
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

  static String toPercentage(num value) {
    value = value > 1.0 ? value : value * 100;

    return "${value.round()}%";
  }

  static String classifyVisibility(num value) {
    if (value < 100) {
      return "Muito baixa";
    }

    if (value < 1000) {
      return "Baixa";
    }

    if (value < 5000) {
      return "Afetada";
    }

    return "Boa";
  }

  static String windSpeed(num value) {
    value = value * 3.6;

    return "${value.toStringAsFixed(2)} km/h";
  }
}