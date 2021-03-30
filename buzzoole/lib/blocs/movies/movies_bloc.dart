import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buzzoole/data/models/favourite.dart';
import 'package:buzzoole/data/models/movie.dart';
import 'package:buzzoole/data/models/movie_detail.dart';
import 'package:buzzoole/data/models/movie_images.dart';
import 'package:buzzoole/data/models/movie_list.dart';
import 'package:buzzoole/data/repositories/movies_repository.dart';
import 'package:meta/meta.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;
  MoviesBloc(this.movieRepository) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    yield FetchingState();
    if (event is TopRatedFetchingEvent) {
      try {
        MovieList _movieList =
            await movieRepository.fetchPopularMovies(event.page);
        if (_movieList != null && _movieList.results.length > 0) {
          yield TopRatedFetchedState(_movieList.results);
        } else if (_movieList != null && _movieList.results.length == 0) {
          yield EmptyState();
        } else {
          yield FailedState();
        }
      } catch (e) {
        yield FailedState();
      }
    } else if (event is DetailFetchingEvent) {
      try {
        MovieDetail _movieDetail =
            await movieRepository.fetchMovieDetail(event.id);
        MovieImages _movieImages =
            await movieRepository.fetchMovieImages(event.id);
        if (_movieDetail != null && _movieImages != null) {
          yield DetailFetchedState(_movieDetail, _movieImages);
        } else {
          yield FailedState();
        }
      } catch (e) {
        yield FailedState();
      }
    } else if (event is MovieCheckingEvent) {
      try {
        bool _watchlisted =
            await movieRepository.checkWatchlistedMovie(event.id);
        if (_watchlisted != null) {
          yield MovieCheckedState(_watchlisted);
        } else {
          yield FailedState();
        }
      } catch (e) {
        yield FailedState();
      }
    } else if (event is SearchingEvent) {
      yield FetchingState();
      try {
        MovieList _movieList =
            await movieRepository.searchMoviesWithTerm(event.term, event.page);
        if (_movieList != null && _movieList.results.length > 0) {
          yield FoundState(_movieList);
        } else if (_movieList != null && _movieList.results.length == 0) {
          yield EmptyState();
        } else {
          yield FailedState();
        }
      } catch (e) {
        yield FailedState();
      }
    } else if (event is SortingEvent) {
      try {
        movieRepository.sortMoviesByVoteCount(event.movies, event.orderBy);
        yield SortedState();
      } catch (e) {
        yield FailedState();
      }
    } else if (event is FavouritesFetchingEvent) {
      yield FetchingState();
      try {
        List<Movie> _favourites =
            await movieRepository.fetchFavouritesFromLocalDatabase();
        if (_favourites.isEmpty) {
          yield EmptyState();
        } else if (_favourites == null) {
          yield FailedState();
        } else {
          yield FavouritesFetchedState(_favourites);
        }
      } catch (e) {
        yield FailedState();
      }
    } else if (event is FavouriteAddingEvent) {
      yield FetchingState();
      try {
        await movieRepository.addFavouriteIntoLocalDatabase(event.favourite);
        yield FavouriteAddedState();
      } catch (e) {
        yield FailedState();
      }
    } else if (event is FavouriteRemovingEvent) {
      yield FetchingState();
      try {
        await movieRepository.removeFavouriteFromLocalDatabase(event.id);
        yield FavouriteRemovedState();
      } catch (e) {
        yield FailedState();
      }
    } else if (event is FavouriteCheckingEvent) {
      yield FetchingState();
      try {
        bool favourited =
            await movieRepository.checkFavouriteFromLocalDatabase(event.id);
        if (favourited != null) {
          yield FavouriteCheckedState(favourited);
        }
      } catch (e) {}
    }
  }
}
