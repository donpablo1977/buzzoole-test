import 'package:buzzoole/blocs/account/account_bloc.dart';
import 'package:buzzoole/blocs/login/login_bloc.dart';
import 'package:buzzoole/data/repositories/account_repository.dart';
import 'package:buzzoole/data/repositories/login_repository.dart';
import 'package:buzzoole/presentation/screens/login_screen.dart';
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
          AccountRepository _accountRepo = AccountRepository();
          return BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(_accountRepo),
            child: MovieListScreen(),
          );
        });
        break;
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
    }
  }
}
