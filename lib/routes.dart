import 'package:brandcare_mobile_flutter_v2/bindings/care_history_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/change_product_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/coupon_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/findAccount_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/genuine_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/guide_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/iamport_payment_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/inquiry_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/invite_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/login_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/mainPage_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/my_product_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/notice_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/point_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/product_info_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/question_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/setting_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/mainShop_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/signup_binding.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/splash_binding.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/findAccount_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/findPW_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/login_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signupSocial_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_complete_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/guide/guide_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/main_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/not_login_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoMain_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareEtc_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCarePayment_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCarePic_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareStatus_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addProductPages/addProductDescription_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addProductPages/addProductImgs_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/care/care_history_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_apply_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_apply_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_history_detail_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_history_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/product_info_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/coupon/add_coupon_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/coupon/coupon_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/coupon/use_coupon_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/genuine_history_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/address_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/my_info_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/name_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/password_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/phone_change_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/info/terms_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/invite/invite_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/notice/notice_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/onetoone_inquiry/onetoone_inquiry_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/point/add_point_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/point/point_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/point/use_point_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/product/modified_product_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/product/my_product_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/product/product_info_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/question/question_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/setting/setting_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopAddProductPages/shopAddProuct_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopDetailPages/shopDetail_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/payment/Iamport_payment_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/splash_page.dart';
import 'package:get/get.dart';

import 'bindings/mainAddCare_binding.dart';
import 'bindings/mainAddProduct_binding.dart';

final routes = [
  GetPage(name: '/splash', page: () => SplashPage(), binding: SplashBinding()),
  GetPage(name: '/auth/login', page: () => LoginPage(), binding: LoginBinding()),
  GetPage(name: '/auth/signup', page: () => SignUpPage(), binding: SignUpBinding()),
  GetPage(name: '/auth/signup/Social', page: () => SignUpSocialPage(), binding: SignUpSocialBinding()),
  GetPage(name: '/auth/signup/complete', page: () => SignUpCompletePage(), binding: SignUpBinding()),
  GetPage(name: '/auth/signupSocial', page: () => SignUpSocialPage(), binding: SignUpSocialBinding()),
  GetPage(name: '/auth/find', page: () => FindAccountPage(), binding: FindAccountBinding()),
  GetPage(name: '/auth/findpw', page: () => FindPWPage(), binding: FindAccountBinding()),
  GetPage(name: '/mainPage', page: () => MainPage(), binding: MainPageBinding()),
  GetPage(name: '/notLoginPage', page: ()=> NotLoginPage()),
  GetPage(name: '/main/my/info', page: () => MyInfoPage()),
  GetPage(name: '/main/my/info/name', page: () => NameChangePage()),
  GetPage(name: '/main/my/info/password', page: () => PasswordChangePage()),
  GetPage(name: '/main/my/info/phone', page: () => PhoneChangePage()),
  GetPage(name: '/main/my/info/address', page: () => AddressChangePage()),
  GetPage(name: '/main/my/notice', page: () => NoticePage(), binding: NoticeBinding(),),
  GetPage(name: '/main/my/question', page: () => QuestionPage(), binding: QuestionBinding()),
  GetPage(name: '/main/my/setting', page: () => SettingPage(), binding: SettingBinding()),
  GetPage(name: '/main/my/inquiry', page: () => OneToOneInquiryPage(), binding: InquiryBinding()),
  GetPage(name: '/main/my/term', page: () => TermsPage()),
  GetPage(name: '/main/my/invite', page: () => InvitePage(), binding: InviteBinding()),
  GetPage(name: '/main/my/coupon', page: () => CouponPage(), binding: CouponBinding()),
  GetPage(name: '/main/my/coupon/use', page: () => CouponUsePage(), binding: CouponBinding()),
  GetPage(name: '/main/my/coupon/add', page: () => CouponAddPage(), binding: CouponBinding()),
  GetPage(name: '/main/my/point/use', page: () => PointUsePage(), binding: PointBinding()),
  GetPage(name: '/main/my/point', page: () => PointPage(), binding: PointBinding()),
  GetPage(name: '/main/my/point/add', page: () => PointAddPage(), binding: PointBinding()),
  GetPage(name: '/main/my/genuine', page: () => GenuineHistoryPage(), binding: GenuineBinding()),
  GetPage(name: '/main/my/care', page: () => CareHistoryPage(), binding: CareHistoryBinding()),
  GetPage(name: '/main/my/product', page: () => MyProductPage(), binding: MyProductBinding()),
  GetPage(name: '/main/my/product/gi/detail', page: () => ProductGiDetailPage(), binding: ProductInfoDetailBinding()),
  GetPage(name: '/main/my/change_product', page: () => ChangeProductPage(), binding: ChangeProductBinding()),
  GetPage(name: '/main/my/change_product/history', page: () => ChangeProductHistoryPage()),
  GetPage(name: '/main/my/change_product/history/detail', page: () => ChangeProductHistoryDetailPage()),
  GetPage(name: '/main/my/change_product/history/product/info', page: () => ProductInfoPage(), binding: ProductInfoBinding()),
  GetPage(name: '/main/my/change_product/apply', page: () => ChangeProductApplyPage()),
  GetPage(name: '/main/my/change_product/apply/complete', page: () => ChangeProductApplyChangePage()),
  GetPage(name: '/modified/product/info', page: () => ModifiedProductPage(), binding: ModifiedProductInfoBinding()),
  GetPage(name: '/mainPage/useInfo/main', page: () => UseInfoMainPage(), binding: UseInfoMainBinding()),
  GetPage(name: '/mainShop/addProduct', page: () => ShopAddProductPage(), binding: MainShopAddProductBinding()),
  GetPage(name: '/mainShop/Detail', page: () => ShopDetailPage(), binding: MainShopDetailBinding()),
  GetPage(name: '/mainAddProduct/addImg', page: () => AddProductImgsPage(), binding: MainAddProductBindings()),
  GetPage(name: '/mainAddProduct/addDescription', page: () => AddProductDescriptionPage(), binding: MainAddProductBindings()),
  GetPage(name: '/mainAddCare/add/pics', page: () => AddCarePicPage(), binding: MainAddCarePicBinding()),
  GetPage(name: '/mainAddCare/add/etc', page: () => AddCareEtcPage(), binding: MainAddCareEtcBinding()),
  GetPage(name: '/mainAddCare/add/payment', page: () => AddCarePaymentPage(), binding: MainAddCarePaymentBinding()),
  GetPage(name: '/mainAddCare/add/status', page: () => AddCareStatusPage(), binding: CareStatusBinding()),
  GetPage(name: '/guide', page: () => GuidePage(), binding: GuideBinding()),
  GetPage(name: '/IamPayment', page: () => IamportPaymentPage(), binding: IamportPaymentBinding()),
];