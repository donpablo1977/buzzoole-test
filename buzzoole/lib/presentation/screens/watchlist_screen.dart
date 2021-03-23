import 'package:buzzoole/blocs/account/account_bloc.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_drawer.dart';
import 'package:buzzoole/presentation/widgets/watchlisted_card.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistScreen extends StatefulWidget {
  WatchlistScreen({Key key}) : super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(WatchlistFetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'WATCHLIST',
            style: BuzzooleTextStyles().setBlackStyle(
                BuzzooleSizingEngine().setMinimumFontSize(context),
                BuzzooleColors().buzzooleMainColor),
          )),
      drawer: BuzzooleDrawer(),
      body: BlocConsumer<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is WatchlistFetchingEvent) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WatchlistFetchedState) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: MediaQuery.of(context).size.height / 3.5,
                ),
                itemCount: state.movieList.results.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/movie_detail',
                            arguments: {
                              'id': state.movieList.results[index].id
                            });
                      },
                      child: WatchlistedCard(
                          movie: state.movieList.results[index]));
                });
          }
          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}