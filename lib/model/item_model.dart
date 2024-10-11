import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ItemModel {

  String label;
  IconData icon;
  Color itemColor;
  Color fundoColor;

  ItemModel({required this.icon, required this.label, required this.fundoColor, required this.itemColor});

  Widget getWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(this.icon, color: this.itemColor,),
        Text(this.label, style: TextStyle(color: this.itemColor),)
      ],
    );
  }

}