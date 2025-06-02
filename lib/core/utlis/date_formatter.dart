import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(final DateTime date) =>
      DateFormat.yMMMd().format(date);
}
// efficiency with extensions