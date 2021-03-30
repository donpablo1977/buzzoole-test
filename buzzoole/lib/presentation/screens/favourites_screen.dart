import 'package:buzzoole/blocs/movies/movies_bloc.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_drawer.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_loader.dart';
import 'package:buzzoole/presentation/widgets/custom_error_widget.dart';
import 'package:buzzoole/presentation/widgets/watchlisted_card.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({Key key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(FavouritesFetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: BuzzooleColors().buzzooleMainColor),
          elevation: 0,
          title: Text(
            'FAVOURITE MOVIES',
            style: BuzzooleTextStyles().setBlackStyle(
                BuzzooleSizingEngine().setMinimumFontSize(context),
                BuzzooleColors().buzzooleMainColor),
          )),
      drawer: BuzzooleDrawer(),
      body: BlocConsumer<MoviesBloc, MoviesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavouritesFetchingEvent) {
            return Center(child: BuzzooleLoader());
          } else if (state is FavouritesFetchedState) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: MediaQuery.of(context).size.height / 3.5,
                ),
                itemCount: state.favourites.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () async {
                        var _returning = await Navigator.of(context).pushNamed(
                            '/movie_detail',
                            arguments: {'id': state.favourites[index].id});
                        if (_returning) {
                          context
                              .read<MoviesBloc>()
                              .add(FavouritesFetchingEvent());
                        }
                      },
                      child: WatchlistedCard(movie: state.favourites[index]));
                });
          } else if (state is EmptyState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomErrorWidget(
                  title: 'OPS!',
                  description: 'YOU NOT HAVE ANY FAVOURITE MOVIE',
                  titleTextStyle: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setMaximumFontSize(context),
                      BuzzooleColors().buzzooleMainColor),
                  descriptionTextStyle: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setMinimumFontSize(context),
                      BuzzooleColors().buzzooleDarkGreyColor)),
            );
          } else if (state is FailedState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomErrorWidget(
                  title: 'OPS!',
                  description: 'WE HAVE SOME PROBLEMS',
                  titleTextStyle: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setMaximumFontSize(context),
                      BuzzooleColors().buzzooleMainColor),
                  descriptionTextStyle: BuzzooleTextStyles().setBlackStyle(
                      BuzzooleSizingEngine().setMinimumFontSize(context),
                      BuzzooleColors().buzzooleDarkGreyColor)),
            );
          }
          return Center(child: BuzzooleLoader());
        },
      ),
    );
  }
}
