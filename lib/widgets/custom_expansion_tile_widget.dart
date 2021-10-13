import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomExpantionTile2 extends StatefulWidget {
  final Widget title;
  final Widget child;
  final bool isShowShadow;

  CustomExpantionTile2({required this.title, required this.child, this.isShowShadow=true});

  @override
  _CustomExpandableState createState() => _CustomExpandableState();
}

class _CustomExpandableState extends State<CustomExpantionTile2>
    with TickerProviderStateMixin {

  bool _isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: widget.isShowShadow ? [
            defaultBoxShadow
          ] : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  _isExpanded = !_isExpanded;
                  if(_controller.isCompleted) {
                    _controller.reverse();
                  } else {
                    _controller.forward(from: 0);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.only(left:10, right:8),
                decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.title,
                    const Spacer(),
                    RotationTransition(
                      turns: Tween(begin: 0.5, end: 0.0).animate(_controller),
                      child: SvgPicture.asset('assets/icons/btn_up.svg', color: gray_666Color,),
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
          ],
        ),
    );
  }
}
