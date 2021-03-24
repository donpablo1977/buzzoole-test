import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/data/models/movie.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_drawer.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_loader.dart';
import 'package:buzzoole/presentation/widgets/custom_error_widget.dart';
import 'package:buzzoole/presentation/widgets/movie_card.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController;
  int _page;
  List<Movie> _movies;
  double _currentPixel;
  String _term;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _movies = [];
    _page = 1;
    _currentPixel = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: BlocConsumer<MoviesBloc, MoviesState>(
            builder: (context, state) {
              return AppBar(
                  backgroundColor: Colors.white,
                  iconTheme:
                      IconThemeData(color: BuzzooleColors().buzzooleMainColor),
                  elevation: 0,
                  title: Text(
                    state is FoundState
                        ? 'HERE IS THE FOUND MOVIES'
                        : 'SEARCH FOR A MOVIE',
                    style: BuzzooleTextStyles().setBlackStyle(
                        BuzzooleSizingEngine().setMinimumFontSize(context),
                        BuzzooleColors().buzzooleMainColor),
                  ));
            },
            listener: (context, state) {},
          ),
        ),
        drawer: BuzzooleDrawer(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {
                if (state is FoundState) {
                  for (var movie in state.movieList.results) {
                    _movies.add(movie);
                  }
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_currentPixel > 0) {
                      _scrollController.jumpTo(
                          _scrollController.position.pixels + _currentPixel);
                      _scrollController.animateTo(
                          _scrollController.position.pixels +
                              MediaQuery.of(context).size.height / 4,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn);
                    }
                  });
                }
              },
              builder: (context, state) {
                if (state is FoundState) {
                  return Container(
                      child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollNotification) {
                        if (_scrollController.offset >=
                            notification.metrics.maxScrollExtent) {
                          _page = _page + 1;
                          context
                              .read<MoviesBloc>()
                              .add(SearchingEvent(_term, _page));
                          _currentPixel = notification.metrics.pixels;
                        }
                        return true;
                      }
                      return false;
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.all(BuzzooleSizingEngine().defaultPadding),
                      child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height / 5,
                          ),
                          itemCount: _movies.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/movie_detail',
                                      arguments: {'id': _movies[index].id});
                                },
                                child: MovieCard(movie: _movies[index]));
                          }),
                    ),
                  ));
                } else if (state is FetchingState) {
                  return Center(
                    child: BuzzooleLoader(),
                  );
                } else if (state is FailedState) {
                  return CustomErrorWidget(
                      title: 'OPS!',
                      description: 'WE HAVE SOME PROBLEMS',
                      titleTextStyle: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMaximumFontSize(context),
                          BuzzooleColors().buzzooleMainColor),
                      descriptionTextStyle: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMinimumFontSize(context),
                          BuzzooleColors().buzzooleDarkGreyColor));
                } else if (state is EmptyState) {
                  return CustomErrorWidget(
                      title: 'OPS!',
                      description: 'NO MOVIES FOUND',
                      titleTextStyle: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMaximumFontSize(context),
                          BuzzooleColors().buzzooleMainColor),
                      descriptionTextStyle: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMinimumFontSize(context),
                          BuzzooleColors().buzzooleDarkGreyColor));
                }
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: BuzzooleSizingEngine().setDefaultSpace(context),
                        right: BuzzooleSizingEngine().setDefaultSpace(context)),
                    child: TextField(
                      onSubmitted: (value) {
                        context
                            .read<MoviesBloc>()
                            .add(SearchingEvent(value, _page));
                        FocusScope.of(context).unfocus();
                      },
                      autofocus: true,
                      cursorWidth: 1,
                      cursorColor: BuzzooleColors().buzzooleMainColor,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor))),
                      style: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMaximumFontSize(context) *
                              3,
                          BuzzooleColors().buzzooleMainColor),
                    ),
                  ),
                );
              },
            )));
  }
}
