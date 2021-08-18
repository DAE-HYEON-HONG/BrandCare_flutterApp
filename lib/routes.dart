import 'package:brandcare_mobile_flutter_v2/bindings/findAccount_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/login_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/mainPage_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/notice_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/question_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/signup_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/splash_binding.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/findAccount_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/login_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/main_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoMain_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/address_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/my_info_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/name_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/password_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/phone_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/notice/notice_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/question/question_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/splash_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/splash', page: () => SplashPage(), binding: SplashBinding()),
  GetPage(name: '/auth/login', page: () => LoginPage(), binding: LoginBinding()),
  GetPage(name: '/auth/signup', page: () => SignUpPage(), binding: SignUpBinding()),
  GetPage(name: '/auth/find', page: () => FindAccountPage(), binding: FindAccountBinding()),
  GetPage(name: '/mainPage', page: () => MainPage(), binding: MainPageBinding()),
  GetPage(name: '/main/my/info', page: () => MyInfoPage()),
  GetPage(name: '/main/my/info/name', page: () => NameChangePage()),
  GetPage(name: '/main/my/info/password', page: () => PasswordChangePage()),
  GetPage(name: '/main/my/info/phone', page: () => PhoneChangePage()),
  GetPage(name: '/main/my/info/address', page: () => AddressChangePage()),
  GetPage(name: '/main/my/notice', page: () => NoticePage(), binding: NoticeBinding()),
  GetPage(name: '/main/my/question', page: () => QuestionPage(), binding: QuestionBinding()),
  GetPage(name: '/mainPage/useInfo/main', page: () => UseInfoMainPage(), binding: UseInfoMainBinding()),
];