import 'dart:convert';

import 'package:buzzoole/data/models/movie_detail.dart';
import 'package:buzzoole/data/models/movie_images.dart';
import 'package:buzzoole/data/models/movie_list.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:http/http.dart' as http;

class MovieAPI {
  Future<MovieList> fetchPopularMovies(int page) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/movie/popular?api_key=${BuzzooleStrings().apiKey}&language=it-IT&page=$page');
    MovieList _movieList;
    if (response.statusCode == 200) {
      _movieList = MovieList.fromJson(jsonDecode(response.body));
    }
    return _movieList;
  }

  Future<MovieDetail> fetchMovieDetail(int id) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/movie/$id?api_key=${BuzzooleStrings().apiKey}&language=it-IT');
    MovieDetail _movieDetail;
    if (response.statusCode == 200) {
      _movieDetail = MovieDetail.fromJson(jsonDecode(response.body));
    }
    return _movieDetail;
  }

  Future<MovieImages> fetchMovieImages(int id) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/movie/$id/images?api_key=${BuzzooleStrings().apiKey}');
    MovieImages _movieImages;
    if (response.statusCode == 200) {
      _movieImages = MovieImages.fromJson(jsonDecode(response.body));
      print(_movieImages.posters.length);
    }
    return _movieImages;
  }

  Future<MovieList> searchMoviesWithTerm(String term) async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/search/movie?api_key=${BuzzooleStrings().apiKey}&language=en-US&query=$term');
    MovieList _movieList;
    if (response.statusCode == 200) {
      _movieList = MovieList.fromJson(jsonDecode(response.body));
    }
    return _movieList;
  }
}
