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

class FetchedEvent extends MoviesEvent {}

class FailedEvent extends MoviesEvent {}
