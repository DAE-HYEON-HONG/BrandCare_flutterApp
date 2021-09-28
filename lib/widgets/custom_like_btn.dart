import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLikeBtn extends StatefulWidget {
  final bool isLiked;
  final Function() onTap;
  CustomLikeBtn({required this.isLiked, required this.onTap});
  @override
  _CustomLikeBtnState createState() => _CustomLikeBtnState();
}

class _CustomLikeBtnState extends State<CustomLikeBtn> with SingleTickerProviderStateMixin {
  double _width = 30;
  double _height = 30;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        widget.onTap();
        if (!widget.isLiked) {
          setState(() {
            _width = 40;
            _height = 40;
          });
          await Future.delayed(Duration(milliseconds: 190), () {
            setState(() {
              _width = 30;
              _height = 30;
            });
          });
        }else {
          setState(() {
            _width = 20;
            _height = 20;
          });
          await Future.delayed(Duration(milliseconds: 190), () {
            setState(() {
              _width = 30;
              _height = 30;
            });
          });
        }
      },
      child: Container(
        width: 50,
        height: 50,
        child: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutQuart,
            child: SvgPicture.asset(
              widget.isLiked ?'assets/icons/ic_heart_on.svg' : 'assets/icons/ic_heart_off.svg',
            ),
          ),
        ),
      ),
    );
  }
}
