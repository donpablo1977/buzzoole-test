import 'package:buzzoole/blocs/login/login_bloc.dart';
import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/data/repositories/login_repository.dart';
import 'package:buzzoole/data/repositories/movies_repository.dart';
import 'package:buzzoole/presentation/screens/login_screen.dart';
import 'package:buzzoole/presentation/screens/movie_detail_scree.dart';
import 'package:buzzoole/presentation/screens/movie_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuzzooleRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<dynamic, dynamic> _args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          LoginRepository _loginRepo = LoginRepository();
          return BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(_loginRepo),
            child: LoginScreen(),
          );
        });
        break;
      case '/movie_list':
        return MaterialPageRoute(builder: (context) {
          MovieRepository _movieRepository = MovieRepository();
          return BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(_movieRepository),
            child: MovieListScreen(),
          );
        });
        break;
      case '/movie_detail':
        return MaterialPageRoute(builder: (context) {
          MovieRepository _movieRepository = MovieRepository();
          return BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(_movieRepository),
            child: MovieDetailScreen(
              id: _args['id'],
            ),
          );
        });
        break;
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
    }
  }
}
