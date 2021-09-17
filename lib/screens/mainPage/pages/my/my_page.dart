import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/route_container_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPage extends StatelessWidget {

  MyPage({Key? key}) : super(key: key);

  final myController = Get.put(MyController());
  final globalCtrl = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    final mainPageCtrl = Get.find<MainPageController>();
    return DefaultAppBarScaffold(
      actions: [
        GestureDetector(
          onTap: (){
            mainPageCtrl.onItemTaped(5);
          },
          child: SvgPicture.asset('assets/icons/mainNotice.svg', height: 19,),
        ),
        const SizedBox(width: 16),
      ],
      isLeadingShow: false,
      title: '나의 정보',
      child: SingleChildScrollView(
        child: Column(
          children: [
            _renderProfile(),
          _renderHistory(),
            const SizedBox(height: 26,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap:(){
                        Get.toNamed('/main/my/point');
                      },
                      child: SvgPicture.asset('assets/icons/point.svg')),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed('/main/my/coupon');
                    },
                      child: SvgPicture.asset('assets/icons/coupon.svg')),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed('/main/my/info');
                    },
                      child: SvgPicture.asset('assets/icons/my_informant.svg')),
                ],
              ),
            ),
            const SizedBox(height: 14,),
            Divider(
              height: 0,
              thickness: 1,
                color: gray_F5F6F7Color
            ),
            ...myController.linkData.entries.map((e) => _renderLinkItem(e.key, e.value)),
            _renderAdBox(),
          ],
        ),
      ),
    );
  }

  Widget _renderProfile() =>
      GetBuilder<MyController>(builder: (_) => Container(
        padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
        child: GestureDetector(
          onTap: (){
            Get.toNamed('/main/my/info');
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Container(
                width: 59,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: myController.myProfileInfoModel!.profile == null ?
                          SvgPicture.asset(
                            'assets/icons/mypage_on.svg',
                            width: 25,
                            height: 25,
                          ):
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ClipOval(
                              child: ExtendedImage.network(
                                BaseApiService.imageApi+myController.myProfileInfoModel!.profile!,
                                fit: BoxFit.cover,
                                cache: true,
                                // ignore: missing_return
                                loadStateChanged: (ExtendedImageState state) {
                                  switch(state.extendedImageLoadState) {
                                    case LoadState.loading :
                                      break;
                                    case LoadState.completed :
                                      break;
                                    case LoadState.failed :
                                      break;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle
                          ),
                          child: Center(child: Icon(Icons.edit_outlined, color: whiteColor,size: 8,))),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 24,),
              Flexible(
                child: Container(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(myController.myProfileInfoModel?.nickName ?? "", style: medium14TextStyle,),
                      const Spacer(),
                      Text(
                        "최근 접속 ${DateFormatUtil.convertDateFormat(date: "${myController.myProfileInfoModel?.lastLoginDate}", format: "yyyy.MM.dd")} ${DateFormatUtil.convertDateFormat(date: "${myController.myProfileInfoModel?.lastLoginDate}", format: "hh:mm:ss")}",
                        style: regular12TextStyle.copyWith(color: gray_333Color),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

  Widget _renderHistory() => Container(
    margin: const EdgeInsets.only(left: 16, top:25, right:16),
    padding: const EdgeInsets.only(top: 15, bottom: 15),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12.h),
      boxShadow: [
        defaultBoxShadow
      ],
    ),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...myController.myData.map((e) {
          return Flexible(
            child: GestureDetector(
              onTap: (){
                if(e.keys.first == '정품인증이력'){
                  Get.toNamed('/main/my/genuine');
                }else if(e.keys.first == '케어/수선이력') {
                  Get.toNamed('/main/my/care');
                }else {
                  Get.toNamed('/main/my/product');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: myController.myData.indexOf(e) != 2 ? Border(
                    right: BorderSide(
                      width: 1,
                      color: gray_F1F3F5Color
                    ),
                  ) : null
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text('${e.keys.first}', style: regular12TextStyle.copyWith(color: gray_333Color),),
                      const SizedBox(height: 16.5,),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: '${e.values.first}', style: medium24TextStyle.copyWith(color: primaryColor)),
                            TextSpan(text: ' 건', style: regular14TextStyle)
                          ]
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        })
      ],
    ),
  );

  Widget _renderLinkItem(String title, String link) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: gray_F5F6F7Color
          )
        )
      ),
      child: RouteContainerWidget(
        title: title, route: link,
      ),
    );
  }

  Widget _renderAdBox() => GetBuilder<MyController>(builder: (_) => Container(
    margin: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 49),
    height: 92,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: ExtendedImage.network(
        BaseApiService.imageApi+myController.bannerList![0].image.path!,
        fit: BoxFit.cover,
        cache: true,
        width: double.infinity,
        height: double.infinity,
        // ignore: missing_return
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              break;
            case LoadState.completed:
              break;
            case LoadState.failed:
              return GestureDetector(
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: primaryColor,
                  ),
                ),
                onTap: () {
                  state.reLoadImage();
                },
              );
              break;
          }
        },
      ),
    ),
  ));
}
