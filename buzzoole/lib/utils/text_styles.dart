import 'package:flutter/material.dart';

class BuzzooleTextStyles {
  static final BuzzooleTextStyles _instance = BuzzooleTextStyles._internal();

  factory BuzzooleTextStyles() {
    return _instance;
  }

  BuzzooleTextStyles._internal();

  TextStyle setBlackStyle(
    double size, [
    Color color,
  ]) {
    return TextStyle(fontFamily: 'Black', fontSize: size, color: color);
  }

  TextStyle setThinStyle(double size, [Color color]) {
    return TextStyle(fontFamily: 'Thin', fontSize: size, color: color);
  }

  TextStyle setBoldStyle(double size, [Color color]) {
    return TextStyle(fontFamily: 'Bold', fontSize: size, color: color);
  }
}
