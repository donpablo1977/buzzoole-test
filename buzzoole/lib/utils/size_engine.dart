import 'package:flutter/material.dart';

class BuzzooleSizingEngine {
  static final BuzzooleSizingEngine _instance =
      BuzzooleSizingEngine._internal();

  factory BuzzooleSizingEngine() {
    return _instance;
  }

  BuzzooleSizingEngine._internal();

  double setDefaultSpace(BuildContext context) {
    return MediaQuery.of(context).size.width / 20;
  }

  double setDefaultFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 25;
  }

  double setMaximumFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 15;
  }

  double setMinimumFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 30;
  }
}
