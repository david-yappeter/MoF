import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatCurrency(dynamic value) {
    final formatter = NumberFormat.currency(locale: 'ID', symbol: "");
    return "IDR " + formatter.format(value);
  }
}
