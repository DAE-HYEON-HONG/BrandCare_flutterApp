import 'package:brandcare_mobile_flutter_v2/bindings/splash_binding.dart';
import 'package:brandcare_mobile_flutter_v2/screens/splash_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/splash', page: () => SplashPage(), binding: SplashBinding())
];