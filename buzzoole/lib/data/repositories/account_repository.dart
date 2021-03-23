import 'package:buzzoole/data/api/account_api.dart';
import 'package:buzzoole/data/models/account.dart';
import 'package:buzzoole/data/models/movie_list.dart';

class AccountRepository {
  AccountAPI _accountAPI = AccountAPI();

  Future<Account> fetchAccountDetails() async {
    return _accountAPI.fetchAccountDetails();
  }

  Future<void> toggleMovieInWatchList(int movieId, bool toggle) async {
    return _accountAPI.toggleMovieInWatchList(movieId, toggle);
  }

  Future<MovieList> getAllWatchlistedMovies() async {
    return _accountAPI.getAllWatchlistedMovies();
  }
}
