import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BuzzooleLoader extends StatelessWidget {
  const BuzzooleLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Lottie.asset('assets/animations/loader.json',
                width: BuzzooleSizingEngine().setMaximumSpace(context),
                height: BuzzooleSizingEngine().setMaximumSpace(context),
                frameRate: FrameRate(120))),
        Text(BuzzooleStrings().getRandomQuote(),
            style: BuzzooleTextStyles().setBlackStyle(
                BuzzooleSizingEngine().setSmallFontSize(context),
                BuzzooleColors().buzzooleDarkGreyColor))
      ],
    );
  }
}
