import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_drawer.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_loader.dart';
import 'package:buzzoole/presentation/widgets/watchlisted_card.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: BlocConsumer<MoviesBloc, MoviesState>(
            builder: (context, state) {
              return AppBar(
                  backgroundColor: Colors.white,
                  iconTheme:
                      IconThemeData(color: BuzzooleColors().buzzooleMainColor),
                  elevation: 0,
                  title: Text(
                    state is FoundState
                        ? 'HERE IS THE FOUND MOVIES'
                        : 'SEARCH FOR A MOVIE',
                    style: BuzzooleTextStyles().setBlackStyle(
                        BuzzooleSizingEngine().setMinimumFontSize(context),
                        BuzzooleColors().buzzooleMainColor),
                  ));
            },
            listener: (context, state) {},
          ),
        ),
        drawer: BuzzooleDrawer(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FoundState) {
                  return Container(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height / 5,
                          ),
                          itemCount: state.movieList.results.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/movie_detail', arguments: {
                                    'id': state.movieList.results[index].id
                                  });
                                },
                                child: WatchlistedCard(
                                    movie: state.movieList.results[index]));
                          }));
                } else if (state is FetchingState) {
                  return Center(
                    child: BuzzooleLoader(),
                  );
                }
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: BuzzooleSizingEngine().setDefaultSpace(context),
                        right: BuzzooleSizingEngine().setDefaultSpace(context)),
                    child: TextField(
                      onSubmitted: (value) {
                        context.read<MoviesBloc>().add(SearchingEvent(value));
                        FocusScope.of(context).unfocus();
                      },
                      autofocus: true,
                      cursorWidth: 1,
                      cursorColor: BuzzooleColors().buzzooleMainColor,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor))),
                      style: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMaximumFontSize(context) *
                              3,
                          BuzzooleColors().buzzooleMainColor),
                    ),
                  ),
                );
              },
            )));
  }
}
