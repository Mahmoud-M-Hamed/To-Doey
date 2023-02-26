import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin TimeAndDateHandler {
  String dateTimeHandler(
      {required String dateFormatPattern, required DateTime dateTime}) {
    final String formattedDate = DateFormat(dateFormatPattern).format(dateTime);
    return formattedDate;
  }

  String timeOfDayHandler(
      {required BuildContext context, required TimeOfDay timeOfDay}) {
    final localizations = MaterialLocalizations.of(context);
    final String formattedTimeOfDay = localizations.formatTimeOfDay(timeOfDay);
    return formattedTimeOfDay;
  }

  Duration fromDateTimeToDuration({required String dateTimeParsing}) {
    DateTime inThePast = DateTime.parse(dateTimeParsing);
    DateTime now = DateTime.now();
    Duration diff = now.difference(inThePast);
    return diff;
  }

  String timeFrom12Hto24H(
      {required String parsingDateTime, required String time12h}) {
    DateTime dateTime = DateTime.parse(parsingDateTime);
    String time24h = DateFormat.Hm().format(DateFormat('yyyy-MM-dd hh:mm a')
        .parse('${dateTime.toString().split(' ')[0]} $time12h'));
    return time24h;
  }

  String notificationDateTime(
      {required String dateToParse, required String timeToParse}) {
    String time24h =
        timeFrom12Hto24H(parsingDateTime: dateToParse, time12h: timeToParse);
    DateTime dateTime = DateTime.parse(dateToParse);
    String parsingDateTime =
        dateTimeHandler(dateFormatPattern: 'yyyy-MM-dd', dateTime: dateTime);
    return '$parsingDateTime $time24h';
  }
}
