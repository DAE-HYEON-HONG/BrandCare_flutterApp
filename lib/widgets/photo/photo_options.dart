import 'package:flutter/material.dart';

class PhotoOptions {
  final int initialIndex;
  final PageController pageController;
  final List items;

  PhotoOptions( this.initialIndex, this.items)
      : pageController = PageController(initialPage: initialIndex);
}
