part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class TopRatedFetchingEvent extends MoviesEvent {
  final int page;

  TopRatedFetchingEvent(this.page);
}

class FavouritesFetchingEvent extends MoviesEvent {
  FavouritesFetchingEvent();
}

class FavouriteAddingEvent extends MoviesEvent {
  final Favourite favourite;
  FavouriteAddingEvent(this.favourite);
}

class FavouriteRemovingEvent extends MoviesEvent {
  final int id;
  FavouriteRemovingEvent(this.id);
}

class FavouriteAddedEvent extends MoviesEvent {
  FavouriteAddedEvent();
}

class FavouriteRemovedEvent extends MoviesEvent {
  FavouriteRemovedEvent();
}

class FavouriteCheckingEvent extends MoviesEvent {
  final int id;
  FavouriteCheckingEvent(this.id);
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
