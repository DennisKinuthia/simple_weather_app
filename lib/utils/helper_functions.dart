import 'package:intl/intl.dart';

String formatDateTime(DateTime today) {
  return DateFormat.MMMEd().format(today).toString();
}
