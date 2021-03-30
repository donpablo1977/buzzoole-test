import 'dart:convert';

import 'package:buzzoole/data/models/favourite.dart';
import 'package:buzzoole/data/models/movie.dart';
import 'package:buzzoole/data/models/movie_detail.dart';
import 'package:buzzoole/data/models/movie_images.dart';
import 'package:buzzoole/data/models/movie_list.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieAPI {
  Future<MovieList> fetchPopularMovies(int page) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/movie/popular?api_key=${BuzzooleStrings().apiKey}&language=it-IT&page=$page');
    MovieList _movieList;
    if (response.statusCode == 200) {
      _movieList = MovieList.fromJson(jsonDecode(response.body));
      sortMoviesByVoteCount(_movieList.results, 'desc');
    } else {
      return null;
    }

    return _movieList;
  }

  Future<MovieDetail> fetchMovieDetail(int id) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/movie/$id?api_key=${BuzzooleStrings().apiKey}&language=en-US');
    MovieDetail _movieDetail;
    if (response.statusCode == 200) {
      _movieDetail = MovieDetail.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
    return _movieDetail;
  }

  Future<MovieImages> fetchMovieImages(int id) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/movie/$id/images?api_key=${BuzzooleStrings().apiKey}');
    MovieImages _movieImages;
    if (response.statusCode == 200) {
      _movieImages = MovieImages.fromJson(jsonDecode(response.body));
    }
    return _movieImages;
  }

  Future<MovieList> searchMoviesWithTerm(String term, int page) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/search/movie?api_key=${BuzzooleStrings().apiKey}&language=en-US&query=$term&page=$page');
    MovieList _movieList;
    if (response.statusCode == 200) {
      _movieList = MovieList.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
    return _movieList;
  }

  void sortMoviesByVoteCount(List<Movie> originalList, String orderBy) {
    if (orderBy == 'asc') {
      originalList.sort((a, b) => a.voteCount.compareTo(b.voteCount));
    } else {
      originalList.sort((a, b) => b.voteCount.compareTo(a.voteCount));
    }
  }

  Future<List<Movie>> fetchFavouritesFromLocalDatabase() async {
    try {
      Database buzzooleDatabase =
          await openDatabase(join(await getDatabasesPath(), 'buzzoole.db'));
      final List<Map<String, dynamic>> favourites =
          await buzzooleDatabase.query('favourites');
      List<Movie> favouriteMovies = [];
      for (var favourite in favourites) {
        Movie movie = Movie(
            title: favourite['title'],
            id: favourite['id'],
            posterPath: favourite['imagePath']);
        favouriteMovies.add(movie);
      }
      return favouriteMovies;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkFavouriteFromLocalDatabase(int id) async {
    try {
      Database buzzooleDatabase =
          await openDatabase(join(await getDatabasesPath(), 'buzzoole.db'));
      final List<Map<String, dynamic>> favourites =
          await buzzooleDatabase.query('favourites');
      List<Movie> favouriteMovies = [];
      for (var favourite in favourites) {
        Movie movie = Movie(
            title: favourite['title'],
            id: favourite['id'],
            posterPath: favourite['imagePath']);
        favouriteMovies.add(movie);
      }
      for (var movie in favouriteMovies) {
        if (movie.id == id) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return null;
    }
  }

  Future<void> addFavouriteIntoLocalDatabase(Favourite favourite) async {
    try {
      Database buzzooleDatabase =
          await openDatabase(join(await getDatabasesPath(), 'buzzoole.db'));
      await buzzooleDatabase.insert('favourites', favourite.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removeFavouriteFromLocalDatabase(int id) async {
    try {
      Database buzzooleDatabase =
          await openDatabase(join(await getDatabasesPath(), 'buzzoole.db'));
      await buzzooleDatabase
          .delete('favourites', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e.toString());
    }
  }
}
