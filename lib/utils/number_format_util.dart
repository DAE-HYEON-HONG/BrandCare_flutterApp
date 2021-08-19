import 'package:intl/intl.dart';

class NumberFormatUtil{

  static String convertNumberFormat({required int number}){
    return NumberFormat('#,###').format(number);
  }

  static String convertNegativePositiveNumber({required int number}) {
    return number.isNegative? '- ${number.abs()}P 차감' : '+ ${number}P 적립';
  }

  static String convertNegativePositiveNumberFormat({required int number}) {
    return number.isNegative? '- ${convertNumberFormat(number: number)}' : '+ ${convertNumberFormat(number: number)}';
  }
}