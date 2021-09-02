import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CareExpansionListField extends StatefulWidget {
  String hintText;
  final Function onTap;
  final List<CareCategoryModel> items;
  final ValueChanged<String> onChange;
  CareExpansionListField({
    required this.onTap,
    required this.hintText,
    required this.items,
    required this.onChange,
  });
  @override
  _CareExpansionListFieldState createState() => _CareExpansionListFieldState();
}

class _CareExpansionListFieldState extends State<CareExpansionListField> with SingleTickerProviderStateMixin{

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
      height: _moreTab ? 60.0 * widget.items.length : 55,
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
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
            _moreTab ? DelayedWidget(
              delayDuration: Duration(milliseconds: 800),
              child: Column(
                children: [
                  const Divider(height: 1, color: gray_f5f6f7Color),
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
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 16, right: 16, top: 13, bottom: 13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.items[idx].title,
                                  style: regular14TextStyle.copyWith(
                                      color: gray_999Color),
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
            ):
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
