import 'package:brandcare_mobile_flutter_v2/bindings/findAccount_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/login_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/mainPage_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/mainShop_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/signup_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/splash_binding.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopDetail/shopDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/findAccount_page.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/mainHome_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/login_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/main_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoMain_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/mainHome_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopAddProductPages/shopAddProuct_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopDetailPages/shopDetail_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/splash_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/splash', page: () => SplashPage(), binding: SplashBinding()),
  GetPage(name: '/auth/login', page: () => LoginPage(), binding: LoginBinding()),
  GetPage(name: '/auth/signup', page: () => SignUpPage(), binding: SignUpBinding()),
  GetPage(name: '/auth/find', page: () => FindAccountPage(), binding: FindAccountBinding()),
  GetPage(name: '/mainPage', page: () => MainPage(), binding: MainPageBinding()),
  GetPage(name: '/mainPage/useInfo/main', page: () => UseInfoMainPage(), binding: UseInfoMainBinding()),
  GetPage(name: '/mainShop/addProduct', page: () => ShopAddProductPage(), binding: MainShopAddProductBinding()),
  GetPage(name: '/mainShop/Detail', page: () => ShopDetailPage(), binding: MainShopDetailBinding()),
];