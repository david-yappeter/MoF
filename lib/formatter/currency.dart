import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatCurrency(dynamic value) {
    final formatter = NumberFormat.currency(locale: 'ID');
    return formatter.format(value);
  }
}
