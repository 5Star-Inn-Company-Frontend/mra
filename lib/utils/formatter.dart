import 'package:intl/intl.dart';

String capitalize(String value) {
  var result = value[0].toUpperCase();
  bool cap = true;
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " " && cap == true) {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
      cap = false;
    }
  }
  return result;
}

String formatDate(String dateString) {
  final dateTime = DateTime.parse(dateString);
  final formattedTime = DateFormat('h:mm a').format(dateTime.toLocal());
  return formattedTime;
}

String formatDateAndTime(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateFormat formatter = DateFormat('d MMM. y, h.mm a');
  return formatter.format(date.subtract(Duration(
      hours: 5,
      minutes:
          46))); // Subtracting 5 hours 46 minutes as the input date is in UTC.
}
