import 'package:buzzoole/blocs/account/account_bloc.dart';
import 'package:buzzoole/blocs/login/login_bloc.dart';
import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/data/repositories/account_repository.dart';
import 'package:buzzoole/data/repositories/login_repository.dart';
import 'package:buzzoole/data/repositories/movies_repository.dart';
import 'package:buzzoole/presentation/screens/favourites_screen.dart';
import 'package:buzzoole/presentation/screens/login_screen.dart';
import 'package:buzzoole/presentation/screens/movie_detail_screen.dart';
import 'package:buzzoole/presentation/screens/movie_list_screen.dart';
import 'package:buzzoole/presentation/screens/search_screen.dart';
import 'package:buzzoole/presentation/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuzzooleRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<dynamic, dynamic> _args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          LoginRepository _repo = LoginRepository();
          return BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(_repo),
            child: LoginScreen(),
          );
        });

        break;
      case '/movie_list':
        return MaterialPageRoute(builder: (context) {
          MovieRepository _repo = MovieRepository();
          return BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(_repo),
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
          AccountRepository _repo = AccountRepository();
          return BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(_repo),
            child: WatchlistScreen(),
          );
        });
      case '/search':
        return MaterialPageRoute(builder: (context) {
          MovieRepository _repo = MovieRepository();
          return BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(_repo),
            child: SearchScreen(),
          );
        });
        break;
      case '/favourite':
        return MaterialPageRoute(builder: (context) {
          MovieRepository _repo = MovieRepository();
          return BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(_repo),
            child: FavouritesScreen(),
          );
        });
        break;
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
    }
  }
}
