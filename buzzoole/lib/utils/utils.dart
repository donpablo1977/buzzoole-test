import 'dart:convert';

import 'package:buzzoole/data/models/movie_list.dart';
import 'package:flutter/material.dart';
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
      return true;
    }
    return false;
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
