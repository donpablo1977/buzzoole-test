import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buzzoole/data/models/account.dart';
import 'package:buzzoole/data/models/movie_list.dart';
import 'package:buzzoole/data/repositories/account_repository.dart';
import 'package:buzzoole/utils/utils.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  AccountBloc(this.accountRepository) : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is FetchingEvent) {
      yield FetchingState();
      try {
        Account _account = await accountRepository.fetchAccountDetails();
        if (_account != null) {
          yield FetchedState();
        }
      } catch (e) {
        yield FailedState();
      }
    } else if (event is WatchlistFetchingEvent) {
      yield WatchlistFetchingState();
      try {
        MovieList _movieList =
            await accountRepository.getAllWatchlistedMovies();
        BuzzooleUtils().setWatchlistInSharedPreferences(_movieList);
        if (_movieList != null && _movieList.results.length > 0) {
          yield WatchlistFetchedState(_movieList);
        } else if (_movieList != null && _movieList.results.length == 0) {
          yield FailedState();
        }
      } catch (e) {
        yield FailedState();
      }
    } else if (event is WatchlistToggleEvent) {
      yield WatchlistTogglingState();
      try {
        final response = await accountRepository.toggleMovieInWatchList(
            event.movieId, event.toggle);
        yield WatchlistToggledState(response);
      } catch (e) {
        yield FailedState();
      }
    }
  }
}
