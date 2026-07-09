import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDayMonthYearTime() {
    return DateFormat('EEE, dd MMM yyyy, hh:mm a').format(this);
  }
}
