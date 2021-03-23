class BuzzooleStrings {
  static final BuzzooleStrings _instance = BuzzooleStrings._internal();

  factory BuzzooleStrings() {
    return _instance;
  }

  BuzzooleStrings._internal();

  String appTitle = 'Buzzole Movie App';
  String baseURL = 'https://api.themoviedb.org/3';
  String imageBaseURL = 'https://image.tmdb.org/t/p/w780/';
  String thumbImageBaseURL = 'https://image.tmdb.org/t/p/w92/';
  String apiKey = '03b2a2cc9c06b7422795af1bc4303030';
  String requestToken;
}
