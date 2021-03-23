import 'package:buzzoole/data/models/movie.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class WatchlistedCard extends StatelessWidget {
  final Movie movie;
  const WatchlistedCard({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                blurRadius: 30,
                color: Colors.black.withAlpha(80),
                offset: Offset(0, 10))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: FadeInImage(
          imageErrorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/logo.png',
              width: BuzzooleSizingEngine().setThumbImageSize(context),
              height: BuzzooleSizingEngine().setThumbImageSize(context)),
          fit: BoxFit.cover,
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(
            '${BuzzooleStrings().imageBaseURL}${movie.posterPath}',
          ),
        ),
      ),
    );
  }
}
