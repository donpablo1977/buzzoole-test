import 'dart:convert';

import 'package:buzzoole/data/models/account.dart';
import 'package:buzzoole/data/models/movie_list.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:buzzoole/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountAPI {
  Future<Account> fetchAccountDetails() async {
    SharedPreferences _preferences =
        await BuzzooleUtils().getSharedPreferences();
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/account?api_key=${BuzzooleStrings().apiKey}&session_id=${_preferences.getString('sessionId')}');
    Account _account;
    if (response.statusCode == 200) {
      _account = Account.fromJson(jsonDecode(response.body));
    }
    return _account;
  }

  Future<bool> toggleMovieInWatchList(int movieId, bool toggle) async {
    SharedPreferences _preferences =
        await BuzzooleUtils().getSharedPreferences();
    await http.post(
        '${BuzzooleStrings().baseURL}/account/${_preferences.getInt('accountId')}/watchlist?api_key=${BuzzooleStrings().apiKey}&session_id=${_preferences.getString('sessionId')}',
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(
            {'media_type': 'movie', 'media_id': movieId, 'watchlist': toggle}));
    return toggle;
  }

  Future<MovieList> getAllWatchlistedMovies() async {
    SharedPreferences _preferences =
        await BuzzooleUtils().getSharedPreferences();
    final response = await http.get(
      '${BuzzooleStrings().baseURL}/account/${_preferences.getInt('accountId')}/watchlist/movies?api_key=${BuzzooleStrings().apiKey}&session_id=${_preferences.getString('sessionId')}',
    );
    MovieList _movieList;
    if (response.statusCode == 200) {
      _movieList = MovieList.fromJson(jsonDecode(response.body));
    }
    return _movieList;
  }
}
