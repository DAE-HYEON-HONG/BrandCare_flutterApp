import 'package:get/get.dart';

class RegexUtil {
  static bool checkEmailRegex({required String email}) {
    return GetUtils.isEmail(email);
  }

  static bool checkPhoneRegex({required String phone}) {
    phone = phone.replaceAll('-', '');
    return GetUtils.isLengthEqualTo(phone, 11);
  }

  static bool checkSMSCodeRegex({required String code}) {
    return GetUtils.isLengthEqualTo(code, 6);
  }

  static bool checkPasswordRegex({required String password}) {
    String regex = r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$";
    print(GetUtils.hasMatch(password, regex));
    return GetUtils.hasMatch(password, regex);
  }
}