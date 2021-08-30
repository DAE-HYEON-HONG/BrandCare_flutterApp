import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomExpansionTileMain extends StatefulWidget {
  final Widget title;
  final Widget child;
  CustomExpansionTileMain({required this.title, required this.child});

  @override
  _CustomExpansionTileMainState createState() => _CustomExpansionTileMainState();
}

class _CustomExpansionTileMainState extends State<CustomExpansionTileMain> with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _aniController;

  @override
  void initState() {
    _aniController = AnimationController(
      duration: const Duration(microseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _aniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                _isExpanded = !_isExpanded;
                if(_aniController.isCompleted) {
                  _aniController.reverse();
                } else {
                  _aniController.forward(from: 0);
                }
              });
            },
            child: Container(
              // padding: const EdgeInsets.only(left:10, right:8),
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.title,
                  const Spacer(),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_aniController),
                    child: SvgPicture.asset('assets/icons/btn_up.svg', color: gray_999Color,),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            vsync: this,
            curve: Curves.fastOutSlowIn,
            child: Container(
              child: Container(
                  child: !_isExpanded
                      ? null
                      : widget.child
              ),
            ),
          ),
          const SizedBox(height: 32,),
        ],
      ),
    );
  }
}
