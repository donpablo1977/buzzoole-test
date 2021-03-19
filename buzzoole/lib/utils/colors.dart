import 'package:flutter/material.dart';

class BuzzooleColors {
  static final BuzzooleColors _instance = BuzzooleColors._internal();

  factory BuzzooleColors() {
    return _instance;
  }

  BuzzooleColors._internal();

  Color buzzooleMainColor = Color.fromRGBO(138, 0, 166, 1);
}
