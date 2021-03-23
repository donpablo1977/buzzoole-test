import 'dart:convert';

import 'package:buzzoole/data/models/movie_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuzzooleUtils {
  static final BuzzooleUtils _instance = BuzzooleUtils._internal();

  factory BuzzooleUtils() {
    return _instance;
  }

  BuzzooleUtils._internal();

  SharedPreferences preferences;

  Future<SharedPreferences> getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> deleteSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Future<void> setUsernameInSharedPreferences(String username) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('username', username);
  }

  Future<void> setSessionIdInSharedPreferences(String sessionId) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('sessionId', sessionId);
  }

  Future<void> setAccountIdInSharedPreferences(int id) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt('accountId', id);
  }

  Future<void> setWatchlistInSharedPreferences(MovieList movieList) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('watchlist', jsonEncode(movieList));
  }

  Future<bool> checkMovieInWatchlist(int movieId) async {
    preferences = await SharedPreferences.getInstance();
    MovieList _movieList =
        MovieList.fromJson(jsonDecode(preferences.getString('watchlist')));
    List _matchedMovieList =
        _movieList.results.where((element) => element.id == movieId).toList();
    if (_matchedMovieList.length > 0) {
      // for (var _movieToDelete in _matchedMovieList) {
      //   _movieList.results.remove(_movieToDelete);
      // }
      // preferences.setString('watchlist', jsonEncode(_movieList));
      return true;
    }
    return false;
  }
}
