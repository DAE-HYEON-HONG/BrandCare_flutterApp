import 'package:get/get.dart';

class RegexUtil {
  static bool checkEmailRegex({required String email}) {
    return GetUtils.isEmail(email);
  }

  static bool checkPhoneRegex({required String phone}) {
    phone = phone.replaceAll('-', '');
    return GetUtils.isLengthEqualTo(phone, 11);
  }
}