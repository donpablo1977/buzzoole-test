part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class TopRatedFetchingEvent extends MoviesEvent {
  final int page;

  TopRatedFetchingEvent(this.page);
}

class DetailFetchingEvent extends MoviesEvent {
  final int id;

  DetailFetchingEvent(this.id);
}

class MovieCheckingEvent extends MoviesEvent {
  final int id;

  MovieCheckingEvent(this.id);
}

class SearchingEvent extends MoviesEvent {
  final String term;
  final int page;
  SearchingEvent(this.term, this.page);
}

class SortingEvent extends MoviesEvent {
  final List<Movie> movies;
  final String orderBy;
  SortingEvent(this.movies, this.orderBy);
}

class FetchedEvent extends MoviesEvent {}

class FailedEvent extends MoviesEvent {}
