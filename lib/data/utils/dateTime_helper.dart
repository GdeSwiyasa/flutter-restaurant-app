import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    final currentTime = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    final returnTime = "11:00:00";
    final fullFormat = DateFormat('y/M/d H:m:s');

    final currentDate = dateFormat.format(currentTime);
    final currentDateAndTime = "$currentDate $returnTime";

    var resultToday = fullFormat.parseStrict(currentDateAndTime);

    var formatted = resultToday.add(Duration(days: 1));
    final dateTomorrow = dateFormat.format(formatted);
    final dateAndTimeTomorrow = "$dateTomorrow $returnTime";
    var resultTomorrow = fullFormat.parseStrict(dateAndTimeTomorrow);

    return currentTime.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
