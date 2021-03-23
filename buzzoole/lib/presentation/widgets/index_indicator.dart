import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';

class IndexIndicator extends StatelessWidget {
  final int index;
  const IndexIndicator({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 0, right: 20, left: 10),
      width: MediaQuery.of(context).size.height / 20,
      height: MediaQuery.of(context).size.height / 20,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                blurRadius: 30,
                color: Colors.black.withAlpha(40),
                offset: Offset(0, 10))
          ]),
      child: Text(index.toString(),
          style: BuzzooleTextStyles().setBlackStyle(
              BuzzooleSizingEngine().setMinimumFontSize(context),
              BuzzooleColors().buzzooleMainColor)),
    );
  }
}
