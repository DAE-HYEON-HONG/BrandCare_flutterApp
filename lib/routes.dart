import 'package:brandcare_mobile_flutter_v2/bindings/login_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/signup_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/splash_binding.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/login_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/splash_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/splash', page: () => SplashPage(), binding: SplashBinding()),
  GetPage(name: '/auth/login', page: () => LoginPage(), binding: LoginBinding()),
  GetPage(name: '/auth/signup', page: () => SignUpPage(), binding: SignUpBinding())
];