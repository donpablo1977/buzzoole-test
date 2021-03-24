import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/data/models/movie.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_drawer.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_loader.dart';
import 'package:buzzoole/presentation/widgets/index_indicator.dart';
import 'package:buzzoole/presentation/widgets/movie_card.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  ScrollController _scrollController;
  int _page;
  List<Movie> _movies;
  double _currentPixel;
  String _orderBy;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _movies = [];
    _page = 1;
    _currentPixel = 0;
    _orderBy = 'desc';
    context.read<MoviesBloc>().add(TopRatedFetchingEvent(_page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'MOVIE LIST',
            style: BuzzooleTextStyles().setBlackStyle(
                BuzzooleSizingEngine().setMinimumFontSize(context),
                BuzzooleColors().buzzooleMainColor),
          )),
      drawer: BuzzooleDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sort),
        onPressed: () {
          if (_orderBy == 'asc') {
            _orderBy = 'desc';
          } else {
            _orderBy = 'asc';
          }
          context.read<MoviesBloc>().add(SortingEvent(_movies, _orderBy));
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is TopRatedFetchedState) {
              for (var movie in state.movies) {
                _movies.add(movie);
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_currentPixel > 0) {
                  _scrollController.jumpTo(
                      _scrollController.position.pixels + _currentPixel);
                  _scrollController.animateTo(
                      _scrollController.position.pixels +
                          MediaQuery.of(context).size.height / 6,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastOutSlowIn);
                }
              });
            }
          },
          builder: (context, state) {
            if (state is FetchingState) {
              return Center(
                child: BuzzooleLoader(),
              );
            } else if (state is TopRatedFetchedState || state is SortedState) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    if (_scrollController.offset >=
                        scrollNotification.metrics.maxScrollExtent) {
                      _page = _page + 1;
                      context
                          .read<MoviesBloc>()
                          .add(TopRatedFetchingEvent(_page));
                      _currentPixel = scrollNotification.metrics.pixels;
                    }
                    return true;
                  }
                  return false;
                },
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          IndexIndicator(index: index + 1),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/movie_detail',
                                    arguments: {'id': _movies[index].id});
                              },
                              child: MovieCard(movie: _movies[index])),
                        ],
                      );
                    }),
              );
            }
            return Center(child: BuzzooleLoader());
          },
        ),
      ),
    );
  }
}
