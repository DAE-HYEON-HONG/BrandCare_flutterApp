import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careSubCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CareSubExpansionListField extends StatefulWidget {
  String hintText;
  final Function onTap;
  final List<CareSubCategoryModel> items;
  final ValueChanged<String> onChange;
  final ValueChanged<int> onPriceChange;
  final ValueChanged<int> changeIdx;
  CareSubExpansionListField({
    required this.onTap,
    required this.hintText,
    required this.items,
    required this.onChange,
    required this.onPriceChange,
    required this.changeIdx,
  });
  @override
  _CareSubExpansionListFieldState createState() => _CareSubExpansionListFieldState();
}

class _CareSubExpansionListFieldState extends State<CareSubExpansionListField> with SingleTickerProviderStateMixin{

  late AnimationController _rotateCtrl;
  late Animation<double> _animation;

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
    widget.onChange(value);
    _handleTap();
  }

  void changePriceValue(int value){
    widget.onPriceChange(value);
  }

  void changeIdx(int value){
    widget.changeIdx(value);
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
      height: _moreTab ? 40.0 * 6 : 51,
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
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              height: 48.8,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _handleTap();
                  widget.onTap();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.hintText,
                        style: regular14TextStyle.copyWith(color: gray_999Color),
                      ),
                    ),
                    RotationTransition(
                      turns: _animation,
                      child: SvgPicture.asset("assets/icons/btn_down.svg"),
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
                height: 37.4*5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, idx) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              changeValue(widget.items[idx].title);
                              changePriceValue(widget.items[idx].price ?? 0);
                              changeIdx(widget.items[idx].id);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 16, right: 16, top: 13, bottom: 13),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.items[idx].title,
                                      style: regular14TextStyle.copyWith(
                                          color: gray_999Color),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Container(
                                    width: 120,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.items[idx].reMark ?? "",
                                          style: regular14TextStyle.copyWith(
                                              color: gray_999Color),
                                        ),
                                        if(widget.items[idx].price != null)
                                        Text(
                                          NumberFormatUtil.convertNumberFormat(number: widget.items[idx].price ?? 0),
                                          style: regular14TextStyle.copyWith(
                                              color: gray_999Color),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ):
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
