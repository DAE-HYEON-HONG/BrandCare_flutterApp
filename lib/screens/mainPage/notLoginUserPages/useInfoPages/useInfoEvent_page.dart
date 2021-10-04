import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoEvent_controller.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UseInfoEventPage extends StatelessWidget {
  final UseInfoEventController controller = Get.put(UseInfoEventController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text("이벤트", style: regular14TextStyle),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: gray_f5f6f7Color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 9),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GetBuilder<UseInfoEventController>(builder: (_) => ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.bannerList?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, idx){
              return _renderAdBox(controller.bannerList?[idx].image.path ?? "", controller.bannerList?[idx].isUrl ?? false, controller.bannerList?[idx].url ?? "");
            },
          )),
        ),
      ],
    );
  }
  Widget _renderAdBox(String imgPath, bool isUrl, String web) => GestureDetector(
    onTap: () {
      if(isUrl){
        controller.launchURL(web);
      }
    },
    child: Container(
      margin: const EdgeInsets.only(top: 14),
      height: 94,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExtendedImage.network(
          BaseApiService.imageApi+imgPath,
          fit: BoxFit.cover,
          cache: true,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    ),
  );
}
