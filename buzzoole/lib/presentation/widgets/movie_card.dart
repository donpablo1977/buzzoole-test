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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withAlpha(50),
                    offset: Offset(0, 0))
              ]),
          child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
              child: FadeInImage(
                height: MediaQuery.of(context).size.height / 6,
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/logo.png',
                    width: BuzzooleSizingEngine().setThumbImageSize(context),
                    height: BuzzooleSizingEngine().setThumbImageSize(context)),
                fit: BoxFit.cover,
                placeholder: AssetImage(
                  'assets/images/logo.png',
                ),
                image: NetworkImage(
                  '${BuzzooleStrings().imageBaseURL}${movie.posterPath}',
                ),
              )),
        ),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5, left: 2, right: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withAlpha(50),
                    offset: Offset(0, 0)),
              ],
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 40,
            child: Text(
              movie.title.toUpperCase(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: BuzzooleTextStyles()
                  .setBlackStyle(10, BuzzooleColors().buzzooleMainColor),
            ))
      ],
    );
  }
}
