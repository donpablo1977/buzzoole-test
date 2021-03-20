import 'package:buzzoole/data/api/movies_api.dart';
import 'package:buzzoole/data/models/movie_detail.dart';
import 'package:buzzoole/data/models/movie_images.dart';
import 'package:buzzoole/data/models/movie_list.dart';

class MovieRepository {
  MovieAPI _movieAPI = MovieAPI();

  Future<MovieList> fetchPopularMovies(int page) async {
    return _movieAPI.fetchPopularMovies(page);
  }

  Future<MovieDetail> fetchMovieDetail(int id) async {
    return _movieAPI.fetchMovieDetail(id);
  }

  Future<MovieImages> fetchMovieImages(int id) async {
    return _movieAPI.fetchMovieImages(id);
  }
}
