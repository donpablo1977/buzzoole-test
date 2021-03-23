import 'package:buzzoole/blocs/account/account_bloc.dart';
import 'package:buzzoole/blocs/login/login_bloc.dart';
import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/data/repositories/account_repository.dart';
import 'package:buzzoole/data/repositories/login_repository.dart';
import 'package:buzzoole/data/repositories/movies_repository.dart';
import 'package:buzzoole/presentation/screens/login_screen.dart';
import 'package:buzzoole/presentation/screens/movie_detail_screen.dart';
import 'package:buzzoole/presentation/screens/movie_list_screen.dart';
import 'package:buzzoole/presentation/screens/watchlist_screen.dart';
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
          AccountRepository _accountRepository = AccountRepository();
          return MultiBlocProvider(providers: [
            BlocProvider<MoviesBloc>(
                create: (context) => MoviesBloc(_movieRepository)),
            BlocProvider<AccountBloc>(
                create: (context) => AccountBloc(_accountRepository))
          ], child: MovieDetailScreen(id: _args['id']));
        });
        break;
      case '/watchlist':
        return MaterialPageRoute(builder: (context) {
          AccountRepository _accountRepository = AccountRepository();
          return BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(_accountRepository),
            child: WatchlistScreen(),
          );
        });
        break;
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
    }
  }
}
