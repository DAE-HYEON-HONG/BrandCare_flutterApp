import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'photo_options.dart';

class PhotoViewWidget extends StatefulWidget {
  final PhotoOptions photoOptions;

  const PhotoViewWidget({Key? key, required this.photoOptions}) : super(key: key);

  @override
  _PhotoViewWidgetState createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {

  late int _currentIndex;


  @override
  void initState() {
    super.initState();
    _currentIndex = widget.photoOptions.initialIndex;
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        // decoration: widget.options.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.photoOptions.items.length,
              backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent
              ),
              pageController: widget.photoOptions.pageController,
              onPageChanged: onPageChanged,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top:10, bottom:10),
                  color: const Color(0xff626262).withOpacity(0.1),
                  child: Stack(
                    children: [
                      Center(child: Text('${_currentIndex+1}/${widget.photoOptions.items.length}')),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child:  Padding(
                            padding: EdgeInsets.only(right: 21.0),
                            child: Icon(Icons.clear, size: 24, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),

          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final item = widget.photoOptions.items[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage('image path'),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 1.5,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }

}
