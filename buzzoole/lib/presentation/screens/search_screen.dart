import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is MovieCheckedState) {
                  return Container();
                }
                return Container();
              },
            )));
  }
}
