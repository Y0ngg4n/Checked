import 'package:checked/collections/task.dart';

mixin DateTimeUtils {
  DateTime? calculateNextDate(
      DateTime? lastDate, RecurringInterval interval, bool checked) {
    DateTime now = DateTime.now();
    if (interval == RecurringInterval.hour) {
      if (lastDate == null || checked) {
        return now.add(const Duration(hours: 1));
      }
    } else if (interval == RecurringInterval.minute) {
      if (lastDate == null || checked) {
        return now.add(const Duration(minutes: 1));
      }
    } else if (lastDate != null) {
      now = addToDateTimeByInterval(now, interval);

      if (checked) {
        return addToDateTimeByInterval(lastDate, interval);
      } else {
        return lastDate;
      }
    }
  }

  String buildDateTimeText(DateTime dateTime) {
    return "${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }

  DateTime addToDateTimeByInterval(
      DateTime dateTime, RecurringInterval interval) {
    switch (interval) {
      case RecurringInterval.minute:
        dateTime.add(Duration(minutes: 1));
        break;
      case RecurringInterval.hour:
        dateTime.add(Duration(hours: 1));
        break;
      case RecurringInterval.day:
        dateTime.add(Duration(days: 1));
        break;
      case RecurringInterval.week:
        dateTime.add(Duration(days: 7));
        break;
      case RecurringInterval.month:
        dateTime = DateTime(dateTime.year, dateTime.month + 1, dateTime.day,
            dateTime.hour, dateTime.minute, dateTime.second);
        break;
      case RecurringInterval.year:
        dateTime = DateTime(dateTime.year + 1, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute, dateTime.second);
        break;
    }
    return dateTime;
  }
}

class DateTimeMaxMin {
  static const _numDays = 100000000;

  static DateTime get min => DateTime.fromMicrosecondsSinceEpoch(0)
      .subtract(const Duration(days: _numDays));

  static DateTime get max => DateTime.fromMicrosecondsSinceEpoch(0)
      .add(const Duration(days: _numDays));
}
