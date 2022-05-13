

import 'package:flutter/cupertino.dart';

class ItemData{



  String title;
  String dec;
  bool isList = false;
  AssetImage image;

  ItemData(this.title, this.dec, this.image, {this.isList});
}