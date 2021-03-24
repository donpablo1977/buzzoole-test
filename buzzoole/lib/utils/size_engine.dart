import 'package:flutter/material.dart';

class BuzzooleSizingEngine {
  static final BuzzooleSizingEngine _instance =
      BuzzooleSizingEngine._internal();

  factory BuzzooleSizingEngine() {
    return _instance;
  }

  BuzzooleSizingEngine._internal();

  double defaultPadding = 10;

  double setDefaultSpace(BuildContext context) {
    return MediaQuery.of(context).size.width / 20;
  }

  double setMinimumSpace(BuildContext context) {
    return MediaQuery.of(context).size.width / 80;
  }

  double setMaximumSpace(BuildContext context) {
    return MediaQuery.of(context).size.width / 5;
  }

  double setDefaultFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 25;
  }

  double setMaximumFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 15;
  }

  double setSmallFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 40;
  }

  double setMinimumFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 30;
  }

  double setThumbImageSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 5;
  }
}
