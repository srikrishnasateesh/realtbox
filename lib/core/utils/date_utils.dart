import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.isAfter(today)) {
    return 'Today ${DateFormat('hh:mm a').format(dateTime)}';
  } else if (dateTime.isAfter(yesterday)) {
    return 'Yesterday ${DateFormat('hh:mm a').format(dateTime)}';
  } else {
    return DateFormat('dd-MM-yy hh:mm a').format(dateTime);
  }
}
