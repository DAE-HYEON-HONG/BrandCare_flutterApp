import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HartWidget extends StatelessWidget {
  const HartWidget({Key? key, required this.isSelect, required this.onChange}) : super(key: key);

  final bool isSelect;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    String asset = isSelect ? 'assets/icons/ic_hart_off.svg' : 'assets/icons/ic_hart_on.svg';
    return GestureDetector(
      onTap: (){
        onChange(!isSelect);
      },
      behavior: HitTestBehavior.translucent,
      child: SvgPicture.asset(asset, width: 31, height: 29,),
    );
  }
}
