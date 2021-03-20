import 'package:buzzoole/blocs/account/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(FetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
    );
  }
}
