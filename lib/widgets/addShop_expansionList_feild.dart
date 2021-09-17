import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/models/category/categoryList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/product/myProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'genuine_box_widget.dart';


class AddShopExpansionListField extends StatefulWidget {
  String hintText;
  final Function onTap;
  final List<MyProduct> items;
  final ValueChanged<int> onChange;
  final ValueChanged<int> idxChange;
  final ScrollController controller;
  AddShopExpansionListField({
    required this.onTap,
    required this.hintText,
    required this.items,
    required this.onChange,
    required this.idxChange,
    required this.controller,
  });
  @override
  _AddShopExpansionListFieldState createState() => _AddShopExpansionListFieldState();
}

class _AddShopExpansionListFieldState extends State<AddShopExpansionListField> with SingleTickerProviderStateMixin{

  late AnimationController _rotateCtrl;
  late Animation<double> _animation;
  int idx = 0;
  int productIdx = 0;

  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeInOutCubic);
  Animatable<double> halfTween = Tween<double>(begin: 0.0, end: 0.5);

  bool _moreTab = false;

  @override
  void initState() {
    _rotateCtrl = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = _rotateCtrl.drive(halfTween.chain(_easeInTween));
    super.initState();
  }

  void _handleTap() {
    print("실행됨");
    setState(() {
      _moreTab = !_moreTab;
    });
    if(_moreTab){
      _rotateCtrl.forward();
    }else{
      _rotateCtrl.reverse();
    }
  }
  
  void changeValue(String value) {
    setState(() {
      widget.hintText = value;
    });
    _handleTap();
  }

  void idxChangeValue(int value){
    print(value);
    widget.idxChange(value);
    setState(() {
      productIdx = value;
    });
  }


  @override
  void dispose() {
    _rotateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOutQuart,
      width: double.infinity,
      height: _moreTab ? 98.0 * 3 : productIdx == 0 ? 55 : 90,
      duration: Duration(milliseconds: 800),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: Color(0xffD5D7DB),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: productIdx == 0 ? 55 : 90,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _handleTap();
                  widget.onTap();
                },
                child: Row(
                  crossAxisAlignment: productIdx == 0 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(productIdx == 0)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          widget.hintText,
                          style: regular14TextStyle.copyWith(color: gray_999Color),
                        ),
                      ),
                    ),
                    if(productIdx != 0)
                    Flexible(
                      child: _item(
                        title: widget.items[idx].title,
                        category: widget.items[idx].category,
                        brand: widget.items[idx].brand,
                        isGenuine: widget.items[idx].genuine == "GENUINE" ? true : false,
                        imgPath: widget.items[idx].thumbnail ?? "",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 5),
                      child: RotationTransition(
                        turns: _animation,
                        child: SvgPicture.asset("assets/icons/btn_down.svg"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(_moreTab)
              const Divider(height: 1, color: gray_f5f6f7Color),
            _moreTab ? DelayedWidget(
              delayDuration: Duration(milliseconds: 800),
              child: Container(
                height: 237,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:  Column(
                    children: [
                      const Divider(height: 1, color: gray_f5f6f7Color),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: widget.controller,
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, idx) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              changeValue(widget.items[idx].title);
                              idxChangeValue(widget.items[idx].productId);
                              widget.onChange(idx);
                              this.idx = idx;
                            },
                            child: Container(
                              width: double.infinity,
                              //padding: EdgeInsets.only(left: 16, right: 16),
                              child: _item(
                                title: widget.items[idx].title,
                                category: widget.items[idx].category,
                                brand: widget.items[idx].brand,
                                isGenuine: widget.items[idx].genuine == "GENUINE" ? true : false,
                                imgPath: widget.items[idx].thumbnail ?? "",
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ):
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required String title,
    required String category,
    required String brand,
    required bool isGenuine,
    required String imgPath,
  }) => Container(
    margin: const EdgeInsets.only(bottom: 8, top: 8),
    padding: const EdgeInsets.only(left: 10, right: 15),
    height: 72,
    child: Row(
      children: [
        imgPath == "" ?
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            border: Border.all(color: gray_999Color),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/header_title_logo.svg",
              height: 10,
            ),
          ),
        ):
        Container(
          width: 72,
          height: 72,
          child: ExtendedImage.network(
            BaseApiService.imageApi+imgPath,
            fit: BoxFit.cover,
            width: double.infinity,
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
        const SizedBox(
          width: 32,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$brand | $category',
                    style: regular12TextStyle.copyWith(color: gray_333Color),
                  ),
                  const Spacer(),
                    GenuineBoxWidget(isGenuine: isGenuine),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: medium14TextStyle,
              )
            ],
          ),
        )
      ],
    ),
  );
}
