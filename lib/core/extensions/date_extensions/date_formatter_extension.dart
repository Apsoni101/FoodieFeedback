import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String toShortDate() => DateFormat.yMMMd().format(this);
}
