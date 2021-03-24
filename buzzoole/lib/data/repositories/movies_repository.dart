import 'package:buzzoole/data/api/movies_api.dart';
import 'package:buzzoole/data/models/movie.dart';
import 'package:buzzoole/data/models/movie_detail.dart';
import 'package:buzzoole/data/models/movie_images.dart';
import 'package:buzzoole/data/models/movie_list.dart';
import 'package:buzzoole/utils/utils.dart';

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

  Future<bool> checkWatchlistedMovie(int id) async {
    return BuzzooleUtils().checkMovieInWatchlist(id);
  }

  Future<MovieList> searchMoviesWithTerm(String term, int page) async {
    return _movieAPI.searchMoviesWithTerm(term, page);
  }

  void sortMoviesByVoteCount(List<Movie> originalList, String orderBy) {
    _movieAPI.sortMoviesByVoteCount(originalList, orderBy);
  }
}
