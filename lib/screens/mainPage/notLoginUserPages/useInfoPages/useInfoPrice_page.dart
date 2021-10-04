import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoPrice_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UseInfoPricePage extends StatelessWidget {
  final UseInfoPriceController controller = Get.put(UseInfoPriceController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(builder: (_) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text("케어/수선 가격표", style: regular14TextStyle),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: gray_f5f6f7Color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Container(
          width: 177.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _priceSelectBtn("전체", 0),
              _priceSelectBtn("가방", 1),
              _priceSelectBtn("지갑", 2),
              _priceSelectBtn("신발", 3),
            ],
          ),
        ),
        const SizedBox(height: 17),
        Obx(() => _careWidget()),
      ],
    ));
  }

  _careWidget() {
    if(controller.currentIdx.value == 0){
      return Column(
        children: <Widget>[
          _bag(),
          _wallet(),
          _shoes(),
        ],
      );
    }else if(controller.currentIdx.value == 1){
      return _bag();
    }else if(controller.currentIdx.value == 2){
      return _wallet();
    }else{
      return _shoes();
    }
  }

  _priceSelectBtn(String title, int isSelected){
    return Obx(() => GestureDetector(
      onTap: () => controller.changeCurrentIdx(isSelected),
      child: Container(
        width: 39.w,
        height: 19.w,
        // padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.w),
          border: Border.all(
            color: isSelected != controller.currentIdx.value ? primaryColor : whiteColor,
          ),
          color: isSelected == controller.currentIdx.value ? primaryColor : whiteColor,
        ),
        child: Center(
          child: Text(
            title,
            style: regular12TextStyle.copyWith(
              color: isSelected == controller.currentIdx.value ? whiteColor : primaryColor,
            ),
          ),
        ),
      ),
    ));
  }

  //가방
  _bag(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("가방", style: medium12TextStyle.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "항목",
                        style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
                      ),
                      Text(
                        "정찰가격",
                        style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Divider(height: 2, color: gray_f5f6f7Color),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, idx) {
                return _list(
                    controller.globalCtrl.careCategory![0].subCategory[idx].title,
                    controller.globalCtrl.careCategory![0].subCategory[idx].price ?? 0,
                    controller.globalCtrl.careCategory![0].subCategory[idx].reMark,
                );
              },
              itemCount: controller.globalCtrl.careCategory![0].subCategory.length,
            ),
          ),
          const SizedBox(height: 16),
          Divider(height: 2, color: gray_f5f6f7Color),
        ],
      ),
    );
  }
  //지갑
  _wallet(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("지갑", style: medium12TextStyle.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "항목",
                        style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
                      ),
                      Text(
                        "정찰가격",
                        style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Divider(height: 2, color: gray_f5f6f7Color),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, idx) {
                return _list(
                  controller.globalCtrl.careCategory![1].subCategory[idx].title,
                  controller.globalCtrl.careCategory![1].subCategory[idx].price ?? 0,
                  controller.globalCtrl.careCategory![1].subCategory[idx].reMark,
                );
              },
              itemCount: controller.globalCtrl.careCategory![1].subCategory.length,
            ),
          ),
          const SizedBox(height: 16),
          Divider(height: 2, color: gray_f5f6f7Color),
        ],
      ),
    );
  }
  //신발
  _shoes(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("신발", style: medium12TextStyle.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "항목",
                        style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
                      ),
                      Text(
                        "정찰가격",
                        style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Divider(height: 2, color: gray_f5f6f7Color),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, idx) {
                return _list(
                  controller.globalCtrl.careCategory![2].subCategory[idx].title,
                  controller.globalCtrl.careCategory![2].subCategory[idx].price ?? 0,
                  controller.globalCtrl.careCategory![2].subCategory[idx].reMark,
                );
              },
              itemCount: controller.globalCtrl.careCategory![2].subCategory.length,
            ),
          ),
          const SizedBox(height: 16),
          Divider(height: 2, color: gray_f5f6f7Color),
        ],
      ),
    );
  }

  _list(String title, int price, String? remark){
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: regular10TextStyle),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  remark ?? "",
                  style: regular10TextStyle,
                ),
                const SizedBox(width: 22),
                Text(NumberFormatUtil.convertNumberFormat(number: price), style: regular10TextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
