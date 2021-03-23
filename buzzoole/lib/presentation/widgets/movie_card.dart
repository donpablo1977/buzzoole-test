import 'package:buzzoole/data/models/movie.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      height: MediaQuery.of(context).size.height / 12,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                blurRadius: 30,
                color: Colors.black.withAlpha(40),
                offset: Offset(0, 10))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
              child: FadeInImage(
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/mini_logo.png',
                    width: BuzzooleSizingEngine().setThumbImageSize(context),
                    height: BuzzooleSizingEngine().setThumbImageSize(context)),
                fit: BoxFit.cover,
                placeholder: AssetImage(
                  'assets/images/mini_logo.png',
                ),
                image: NetworkImage(
                  '${BuzzooleStrings().thumbImageBaseURL}${movie.posterPath}',
                ),
              )),
          SizedBox(width: BuzzooleSizingEngine().setDefaultSpace(context)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  movie.title.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setMinimumFontSize(context),
                      BuzzooleColors().buzzooleMainColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
