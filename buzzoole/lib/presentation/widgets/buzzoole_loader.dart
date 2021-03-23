import 'package:buzzoole/utils/size_engine.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BuzzooleLoader extends StatelessWidget {
  const BuzzooleLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Lottie.asset('assets/animations/loader.json',
            width: BuzzooleSizingEngine().setDefaultSpace(context) * 4,
            height: BuzzooleSizingEngine().setDefaultSpace(context) * 4,
            frameRate: FrameRate(120)));
  }
}
