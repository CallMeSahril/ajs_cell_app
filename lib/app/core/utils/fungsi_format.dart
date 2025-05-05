import 'package:intl/intl.dart';

String formatRange(String range) {
  final parts = range.split(' - ');
  if (parts.length != 2) return range;

  final low = formatCurrency(parts[0]);
  final high = formatCurrency(parts[1]);

  return '$low - $high';
}

String formatCurrency(String value) {
  final number = double.tryParse(value);
  if (number == null) return value;

  // Menggunakan NumberFormat dari intl package
  return 'Rp ${NumberFormat("#,##0", "id_ID").format(number)}';
}

