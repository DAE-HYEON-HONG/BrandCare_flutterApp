import 'package:app_settings/app_settings.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingController extends BaseController {

  final GlobalController globalCtrl = Get.find<GlobalController>();
  final MyController myCtrl = Get.find<MyController>();

  @override
  void onInit() async{
    await notificationPermissionChk();
    if(isNotification){
      await myCtrl.myInfo();
      alarmAdd();
    }
    super.onInit();
  }

  Map<String, String> linkData = {
    '이용약관': '/main/my/term',
    '개인정보 취급방침': '/main/my/term'
  };

  Map<String, String> actionData = {
    '로그아웃': 'logout',
    '회원 탈퇴': 'withdrawal'
  };

  RxBool isProgressAlarm = false.obs;
  RxBool isProductAlarm = false.obs;
  RxBool isShopAlarm = false.obs;
  RxBool isEtcAlarm = false.obs;
  bool isNotification = false;

  void openNotificationSettings() async{
    AppSettings.openNotificationSettings();
    await notificationPermissionChk();
    if(isNotification){
      alarmAdd();
    }
  }

  void alarmAdd(){
    for(var addValue in globalCtrl.userInfoModel!.alarmIds){
      if(addValue == 1){
        isProgressAlarm.value = true;
      }else if(addValue == 2){
        isProductAlarm.value = true;
      }else if(addValue == 3){
        isShopAlarm.value = true;
      }else if(addValue == 4){
        isEtcAlarm.value = true;
      }
    }
  }

  Future<void> notificationPermissionChk() async{
    print(await Permission.notification.request().isGranted);
    isNotification = await Permission.notification.request().isGranted;
    update();
  }

  showLogoutDialog() {
    Get.dialog(
      CustomDialogWidget(content: '정말 로그아웃 하시겠습니까?', onClick: (){
        showLoginRouteDialog('로그아웃');
      },
        isSingleButton: false,
        title: '로그아웃',
      ),
      barrierDismissible: false
    );
  }

  Future<dynamic>deleteUser(int userIdx) async{
    final res = await AuthProvider().deleteUser(userIdx);
    return res;
  }

  void changeAlarm(int type)async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await MyProvider().changeAlarm(token!, type);
    if(!res){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            Get.back();
            update();
          })
      );
    }
  }

  showWithdrawalDialog() {
    Get.dialog(
        CustomDialogWidget(content: '계정 정보 및 제품 정보가\n모두 삭제되며 복구되지 않습니다.\n정말 탈퇴 하시겠습니까?',
          onClick: () async{
          final res = await deleteUser(globalCtrl.userInfoModel!.userId);
          print(res);
          if(res == null){
            Get.dialog(
                CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
                  Get.back();
                  Get.back();
                  update();
                })
            );
            return;
          }
          showLoginRouteDialog('회원탈퇴가');
        },
          isSingleButton: false,
          title: '회원탈퇴',
        ),
        barrierDismissible: false
    );
  }

  showLoginRouteDialog(String content) {
    Get.dialog(
      CustomDialogWidget(content: '$content 완료되었습니다.', onClick: (){
        Get.offAllNamed('/auth/login');
        SharedTokenUtil.saveBool(false, 'isAutoLogin');
        SharedTokenUtil.remove('userLogin_token');
      }),
      barrierDismissible: false,
    );
  }

}