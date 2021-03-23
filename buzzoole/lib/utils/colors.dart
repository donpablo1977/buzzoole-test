import 'package:flutter/material.dart';

class BuzzooleColors {
  static final BuzzooleColors _instance = BuzzooleColors._internal();

  factory BuzzooleColors() {
    return _instance;
  }

  BuzzooleColors._internal();

  Color buzzooleMainColor = Color.fromRGBO(222, 34, 80, 1);
  Color buzzooleDarkGreyColor = Color.fromRGBO(50, 50, 50, 1);
  Color buzzooleSplashColor = Color.fromRGBO(138, 0, 166, 1).withAlpha(90);
  Color buzzooleHighlightColor = Color.fromRGBO(138, 0, 166, 1).withAlpha(30);
}
