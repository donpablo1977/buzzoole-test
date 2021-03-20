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

class FailedState extends MoviesState {}
