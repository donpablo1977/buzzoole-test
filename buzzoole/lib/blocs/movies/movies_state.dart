part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class FetchingState extends MoviesState {}

class TopRatedFetchedState extends MoviesState {
  final List<Movie> movies;

  TopRatedFetchedState(this.movies);
}

class DetailFetchedState extends MoviesState {
  final MovieDetail movieDetail;
  final MovieImages movieImages;

  DetailFetchedState(this.movieDetail, this.movieImages);
}

class MovieCheckedState extends MoviesState {
  final bool watchListed;
  MovieCheckedState(this.watchListed);
}

class FoundState extends MoviesState {
  final MovieList movieList;
  FoundState(this.movieList);
}

class SortedState extends MoviesState {
  SortedState();
}

class EmptyState extends MoviesState {}

class FailedState extends MoviesState {}
