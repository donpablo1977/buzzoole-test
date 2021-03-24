import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:buzzoole/utils/utils.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final String route;
  const DrawerMenuItem(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (this.route == '/') {
          await BuzzooleUtils().deleteSharedPreferences();
        }
        Navigator.of(context).pushNamedAndRemoveUntil(
            this.route, ModalRoute.withName(this.route));
      },
      splashColor: BuzzooleColors().buzzooleSplashColor,
      highlightColor: BuzzooleColors().buzzooleHighlightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: this.icon,
            margin: EdgeInsets.only(
                left: BuzzooleSizingEngine().setDefaultSpace(context)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                left: BuzzooleSizingEngine().setDefaultSpace(context)),
            height: MediaQuery.of(context).size.height / 10,
            child: Text(
              this.title,
              style: BuzzooleTextStyles().setBlackStyle(
                  BuzzooleSizingEngine().setDefaultFontSize(context),
                  BuzzooleColors().buzzooleMainColor),
            ),
          ),
        ],
      ),
    );
  }
}
