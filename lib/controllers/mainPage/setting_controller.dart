import 'package:app_settings/app_settings.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class SettingController extends BaseController {

  GlobalController globalCtrl = Get.find<GlobalController>();

  Map<String, String> linkData = {
    '이용약관': '/main/my/term',
    '개인정보 취급방침': '/main/my/term'
  };

  Map<String, String> actionData = {
    '로그아웃': 'logout',
    '회원 탈퇴': 'withdrawal'
  };

  Rx<bool> isAlarm = false.obs;

  void openNotificationSettings() {
    AppSettings.openNotificationSettings();
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

  Future<void>deleteUser(int userIdx) async{
    final res = await AuthProvider().deleteUser(userIdx);
  }

  showWithdrawalDialog() {
    Get.dialog(
        CustomDialogWidget(content: '계정 정보 및 제품 정보가\n모두 삭제되며 복구되지 않습니다.\n정말 탈퇴 하시겠습니까?',
          onClick: () async{
          await deleteUser(globalCtrl.userInfoModel!.userId);
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