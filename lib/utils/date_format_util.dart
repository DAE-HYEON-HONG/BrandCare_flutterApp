import 'package:intl/intl.dart';

class DateFormatUtil{

  static String getTimeAtDateTime(String date) {
    DateTime convertDate = DateFormat('yyyy-MM-DDThh:mm:ss').parse(date);
    return DateFormat('hh:mm').format(convertDate);
  }

  static String convertDateFormat({required String date, String format='yyyy-MM-DD'}) {
    DateTime convertDate = DateFormat('yyyy-MM-DDThh:mm:ss').parse(date);
    return DateFormat(format).format(convertDate);
  }

  static String convertDateTimeFormat({required String date}) {
    DateTime convertDate = DateFormat('yyyy-MM-DDThh:mm:ss').parse(date);
    return DateFormat('yyyy-MM-DD hh:mm').format(convertDate);
  }

  static String convertOnlyDate({required String date}){
    DateTime convertDate = DateFormat('yyyy-MM-DDThh:mm:ss').parse(date);
    return DateFormat('yyyy-MM-DD').format(convertDate);
  }

  static String convertOnlyTime({required String date}){
    DateTime convertDate = DateFormat('yyyy-MM-DDThh:mm:ss').parse(date);
    return DateFormat('hh:mm').format(convertDate);
  }

  static String convertTimer({required int timer}) {
    int min = (timer / 60).floor();
    int second = timer % 60;
    return '$min:$second';
  }
}