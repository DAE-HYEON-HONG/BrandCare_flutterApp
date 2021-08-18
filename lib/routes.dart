import 'package:brandcare_mobile_flutter_v2/bindings/findAccount_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/login_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/mainPage_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/signup_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/splash_binding.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/findAccount_page.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/mainHome_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/login_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/main_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/MainHome_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/address_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/my_info_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/name_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/password_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/phone_change_page.dart';
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
];