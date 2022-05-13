import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

// ignore: must_be_immutable
class ViewImage extends StatelessWidget {
  String image;

  ViewImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      color: Colors.black,
      child: PinchZoom(
        child: Image.file(File(image)),
        //zoomedBackgroundColor: Colors.black.withOpacity(0.5),
        resetDuration: const Duration(milliseconds: 100000),
        maxScale: 2.5,
      ),
    );
  }
}
