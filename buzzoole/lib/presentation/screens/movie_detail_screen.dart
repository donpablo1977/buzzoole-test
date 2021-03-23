import 'package:buzzoole/blocs/account/account_bloc.dart';
import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/data/models/movie_detail.dart';
import 'package:buzzoole/data/models/movie_images.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:favorite_button/favorite_button.dart';
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
  double rating = 0;
  MovieDetail _detail;
  MovieImages _images;

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(WatchlistFetchingEvent());
    context.read<MoviesBloc>().add(DetailFetchingEvent(this.widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesBloc, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DetailFetchedState) {
          _detail = state.movieDetail;
          _images = state.movieImages;
          context
              .read<MoviesBloc>()
              .add(MovieCheckingEvent(state.movieDetail.id));
        }
        return BlocConsumer<MoviesBloc, MoviesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MovieCheckedState) {
              return Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      _detail.title.toUpperCase(),
                      style: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMinimumFontSize(context),
                          BuzzooleColors().buzzooleMainColor),
                    )),
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(BuzzooleSizingEngine()
                                  .setDefaultSpace(context)),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                child: Swiper(
                                  loop: true,
                                  autoplay: true,
                                  autoplayDisableOnInteraction: true,
                                  duration: 500,
                                  curve: Curves.fastOutSlowIn,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image.network(
                                      '${BuzzooleStrings().imageBaseURL}${_images.backdrops[index].filePath}',
                                      fit: BoxFit.fitHeight,
                                    );
                                  },
                                  itemCount: _images.backdrops.length,
                                ),
                              ),
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 30,
                                    color: Colors.black.withAlpha(100))
                              ])),
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(BuzzooleSizingEngine()
                                      .setDefaultSpace(context)),
                                  child: Text(
                                    _detail.overview.toUpperCase(),
                                    textAlign: TextAlign.justify,
                                    style: BuzzooleTextStyles().setBlackStyle(
                                        BuzzooleSizingEngine()
                                            .setMinimumFontSize(context)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                            ('${(_detail.popularity / 1000).round().toString()}K'),
                                            style: BuzzooleTextStyles()
                                                .setBlackStyle(
                                                    BuzzooleSizingEngine()
                                                        .setMaximumFontSize(
                                                            context),
                                                    BuzzooleColors()
                                                        .buzzooleMainColor)),
                                        Text(('POPOLARITÀ'),
                                            style: BuzzooleTextStyles()
                                                .setBlackStyle(
                                                    BuzzooleSizingEngine()
                                                        .setMinimumFontSize(
                                                            context),
                                                    BuzzooleColors()
                                                        .buzzooleDarkGreyColor))
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: 30,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            ('${_detail.voteAverage.toString()}'),
                                            style: BuzzooleTextStyles()
                                                .setBlackStyle(
                                                    BuzzooleSizingEngine()
                                                        .setMaximumFontSize(
                                                            context),
                                                    BuzzooleColors()
                                                        .buzzooleMainColor)),
                                        Text(('MEDIA VOTI'),
                                            style: BuzzooleTextStyles()
                                                .setBlackStyle(
                                                    BuzzooleSizingEngine()
                                                        .setMinimumFontSize(
                                                            context),
                                                    BuzzooleColors()
                                                        .buzzooleDarkGreyColor))
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: 30,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            ('${(_detail.voteCount / 1000).toString()}K'),
                                            style: BuzzooleTextStyles()
                                                .setBlackStyle(
                                                    BuzzooleSizingEngine()
                                                        .setMaximumFontSize(
                                                            context),
                                                    BuzzooleColors()
                                                        .buzzooleMainColor)),
                                        Text(('VOTI RICEVUTI'),
                                            style: BuzzooleTextStyles()
                                                .setBlackStyle(
                                                    BuzzooleSizingEngine()
                                                        .setMinimumFontSize(
                                                            context),
                                                    BuzzooleColors()
                                                        .buzzooleDarkGreyColor))
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 50,
                        left: MediaQuery.of(context).size.width / 2 -
                            MediaQuery.of(context).size.width / 10,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.width / 5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      blurRadius: 10,
                                      color: Colors.black.withAlpha(15))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: FavoriteButton(
                              isFavorite: state.watchListed,
                              iconColor: BuzzooleColors().buzzooleMainColor,
                              valueChanged: (_isWatchlisted) async {
                                if (state.watchListed) {
                                  BlocProvider.of<AccountBloc>(context).add(
                                      WatchlistToggleEvent(_detail.id, false));
                                } else {
                                  BlocProvider.of<AccountBloc>(context).add(
                                      WatchlistToggleEvent(_detail.id, true));
                                }
                              },
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        );
      },
    );
  }
}
