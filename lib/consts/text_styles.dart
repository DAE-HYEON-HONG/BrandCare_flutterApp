import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double _largeFontSize = 24.sp;
double _mediumFontSize2x = 16.sp;
double _mediumFontSize = 14.sp;
double _smallFontSize2X = 12.sp;
double _smallFontSize = 10.sp;

// double _largeFontSize = 24;
// double _mediumFontSize2x = 20;
// double _mediumFontSize = 18;
// double _smallFontSize2X = 16;
// double _smallFontSize = 14;

// double _largeFontSize = 24;
// double _mediumFontSize2x = 18;
// double _mediumFontSize = 16;
// double _smallFontSize2X = 14;
// double _smallFontSize = 12;

const TextStyle _defaultTextStyle = TextStyle(fontFamily: 'NotoSans', color: blackColor);

TextStyle medium24TextStyle = _defaultTextStyle.copyWith(fontSize: _largeFontSize, fontWeight: FontWeight.w500);
TextStyle medium16TextStyle = _defaultTextStyle.copyWith(fontSize: _mediumFontSize2x, fontWeight: FontWeight.w500);
TextStyle medium14TextStyle = _defaultTextStyle.copyWith(fontSize: _mediumFontSize, fontWeight: FontWeight.w500);
TextStyle medium12TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize2X, fontWeight: FontWeight.w500);
TextStyle medium10TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize, fontWeight: FontWeight.w500);

TextStyle regular14TextStyle = _defaultTextStyle.copyWith(fontSize: _mediumFontSize, fontWeight: FontWeight.w400);
TextStyle regular12TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize2X, fontWeight: FontWeight.w400);
TextStyle regular10TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize, fontWeight: FontWeight.w400);




