import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';

class BuzzooleDrawer extends StatelessWidget {
  const BuzzooleDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Image.asset('assets/images/logo.png',
                width: BuzzooleSizingEngine().setThumbImageSize(context),
                height: BuzzooleSizingEngine().setThumbImageSize(context)),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/search');
              },
              splashColor: BuzzooleColors().buzzooleSplashColor,
              highlightColor: BuzzooleColors().buzzooleHighlightColor,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: BuzzooleSizingEngine().setDefaultSpace(context)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 10,
                child: Text(
                  'SEARCH A MOVIE',
                  style: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setDefaultFontSize(context),
                      BuzzooleColors().buzzooleMainColor),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/movie_list');
              },
              splashColor: BuzzooleColors().buzzooleSplashColor,
              highlightColor: BuzzooleColors().buzzooleHighlightColor,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: BuzzooleSizingEngine().setDefaultSpace(context)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 10,
                child: Text(
                  'MOVIE LIST',
                  style: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setDefaultFontSize(context),
                      BuzzooleColors().buzzooleMainColor),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/watchlist');
              },
              splashColor: BuzzooleColors().buzzooleSplashColor,
              highlightColor: BuzzooleColors().buzzooleHighlightColor,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: BuzzooleSizingEngine().setDefaultSpace(context)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 10,
                child: Text(
                  'WATCHLIST',
                  style: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setDefaultFontSize(context),
                      BuzzooleColors().buzzooleMainColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
