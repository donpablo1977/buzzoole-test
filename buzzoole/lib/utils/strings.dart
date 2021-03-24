import 'dart:math';

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

  List<String> quotes = [
    'MAKE IT HAPPEN',
    'DO WHAT YOU LOVE',
    'LET LIFE SURPRISE YOU',
    'THE BEST IS YET TO COME',
    'STAY HUNGRY, STAY FOOLISH',
    "DON'T BE AFRAID TO DREAM BIG",
    'YOU ARE YOUR ONLY LIMIT',
    'IF YOU CAN DREAM IT, YOU CAN DO IT',
    'MY LIFE IS MY MESSAGE'
  ];

  String getRandomQuote() {
    int randomNumber = 0 + Random().nextInt(quotes.length - 0);
    return quotes[randomNumber];
  }
}
