import 'package:buzzoole/blocs/movies/movies_bloc.dart';
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
  int page;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    page = 1;
    context.read<MoviesBloc>().add(TopRatedFetchingEvent(page));
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is TopRatedFetchedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.fixed,
                  backgroundColor: Colors.white,
                  duration: Duration(milliseconds: 1500),
                  content: Container(
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      'YOU HAVE LOADED PAGE $page',
                      textAlign: TextAlign.center,
                      style: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMinimumFontSize(context),
                          BuzzooleColors().buzzooleMainColor),
                    ),
                  )));
            }
          },
          builder: (context, state) {
            if (state is FetchingState) {
              return Center(
                child: BuzzooleLoader(),
              );
            } else if (state is TopRatedFetchedState) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    if (_scrollController.offset >=
                        scrollNotification.metrics.maxScrollExtent) {
                      page = page + 1;
                      context
                          .read<MoviesBloc>()
                          .add(TopRatedFetchingEvent(page));
                    } else if (_scrollController.offset <= 0) {
                      if (page > 1) {
                        page = page - 1;
                        context
                            .read<MoviesBloc>()
                            .add(TopRatedFetchingEvent(page));
                      }
                    }
                    return true;
                  }
                  return false;
                },
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          IndexIndicator(index: index + 1),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/movie_detail',
                                    arguments: {'id': state.movies[index].id});
                              },
                              child: MovieCard(movie: state.movies[index])),
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
