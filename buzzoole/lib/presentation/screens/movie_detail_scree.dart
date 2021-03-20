import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;
  const MovieDetailScreen({Key key, @required this.id}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(DetailFetchingEvent(this.widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<MoviesBloc, MoviesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is DetailFetchedState) {
              return Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Swiper(
                        loop: true,
                        autoplay: true,
                        autoplayDisableOnInteraction: true,
                        duration: 500,
                        curve: Curves.fastOutSlowIn,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            '${BuzzooleStrings().imageBaseURL}${state.movieImages.backdrops[index].filePath}',
                            fit: BoxFit.fitHeight,
                          );
                        },
                        itemCount: state.movieImages.backdrops.length,
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 30,
                            color: Colors.black.withAlpha(50))
                      ])),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5),
                          child: Text(
                            state.movieDetail.title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: BuzzooleTextStyles().setBlackStyle(
                                BuzzooleSizingEngine()
                                    .setMaximumFontSize(context),
                                BuzzooleColors().buzzooleMainColor),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5),
                          child: Text(
                            state.movieDetail.genres[0].name.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: BuzzooleTextStyles().setBlackStyle(
                                BuzzooleSizingEngine()
                                    .setDefaultFontSize(context)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5),
                          child: Text(
                            state.movieDetail.budget.toString(),
                            textAlign: TextAlign.center,
                            style: BuzzooleTextStyles().setBlackStyle(
                                BuzzooleSizingEngine()
                                    .setDefaultFontSize(context)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5),
                          child: Text(
                            state.movieDetail.overview.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: BuzzooleTextStyles().setBlackStyle(
                                BuzzooleSizingEngine()
                                    .setDefaultFontSize(context)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
