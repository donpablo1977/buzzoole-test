import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/presentation/widgets/index_indicator.dart';
import 'package:buzzoole/presentation/widgets/movie_card.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<MoviesBloc, MoviesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchingState) {
              return Center(
                child: CircularProgressIndicator(),
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
                          IndexIndicator(page: page, index: index),
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
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
