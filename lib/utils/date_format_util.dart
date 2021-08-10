import 'package:intl/intl.dart';

class DateFormatUtil{

  static String getTimeAtDateTime(String date) {
    DateTime convertDate = DateFormat('YYYY-MM-DDThh:mm:ss').parse(date);
    return DateFormat('hh:mm').format(convertDate);
  }

  static String convertDateFormat({required String date, String? format}) {
    DateTime convertDate = DateFormat('YYYY-MM-DDThh:mm:ss').parse(date);
    String _format = 'YYYY-MM-DD';
    if(format != null) _format = format;
    return DateFormat(_format).format(convertDate);
  }

}