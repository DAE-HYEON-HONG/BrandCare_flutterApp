import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomExpansionFeild extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final Function() onTap;
  bool readMode = false;
  CustomExpansionFeild({
    required this.controller,
    required this.placeholder,
    required this.onTap,
    required this.readMode,
  });

  @override
  _CustomExpansionFeildState createState() => _CustomExpansionFeildState();
}

class _CustomExpansionFeildState extends State<CustomExpansionFeild> with SingleTickerProviderStateMixin {

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
    setState(() {
      _moreTab = !_moreTab;
    });
    if(_moreTab){
      _rotateCtrl.forward();
    }else{
      _rotateCtrl.reverse();
    }
  }

  @override
  void dispose() {
    _rotateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffD5D7DB),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: GestureDetector(
            onTap: () {
              _handleTap();
              widget.onTap();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextFormField(
                    readOnly: widget.readMode,
                    controller: widget.controller,
                    style: regular12TextStyle.copyWith(color: gray_999Color),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: widget.placeholder,
                      hintStyle: regular12TextStyle.copyWith(color: gray_999Color),
                    ),
                  ),
                ),
                RotationTransition(
                  turns: _animation,
                  child: SvgPicture.asset(
                    "assets/icons/btn_down.svg"
                  ),
                )
              ],
            ),
          ),
        ),
        // _moreTab == true ?
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   top: 0,
        //   child: InkWell(
        //     onTap: () {
        //       print("실행됨?");
        //       _handleTap();
        //     },
        //     child: Container(
        //       width: double.infinity,
        //       height: double.infinity,
        //     ),
        //   ),
        // ):
        // sizeH(0.0),
        //혹시나 해서 stack으로 둠...
      ],
    );
  }
}