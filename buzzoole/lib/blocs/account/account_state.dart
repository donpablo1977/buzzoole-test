part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class FetchingState extends AccountState {}

class FetchedState extends AccountState {}

class WatchlistFetchingState extends AccountState {}

class WatchlistFetchedState extends AccountState {
  final MovieList movieList;

  WatchlistFetchedState(this.movieList);
}

class WatchlistTogglingState extends AccountState {}

class WatchlistToggledState extends AccountState {
  final bool watchlisted;

  WatchlistToggledState(this.watchlisted);
}

class FailedState extends AccountState {}
