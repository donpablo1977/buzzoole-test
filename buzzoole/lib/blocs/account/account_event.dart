part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class FetchingEvent extends AccountEvent {}

class FetchedEvent extends AccountEvent {}

class WatchlistFetchingEvent extends AccountEvent {}

class WatchlistFetchedEvent extends AccountEvent {}

class WatchlistToggleEvent extends AccountEvent {
  final int movieId;
  final bool toggle;
  WatchlistToggleEvent(this.movieId, this.toggle);
}

class WatchlistAddedEvent extends AccountEvent {}

class FailedEvent extends AccountEvent {}
