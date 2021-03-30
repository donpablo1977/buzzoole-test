import 'package:buzzoole/presentation/widgets/drawer_menu_item.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:flutter/material.dart';

class BuzzooleDrawer extends StatelessWidget {
  const BuzzooleDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: BuzzooleSizingEngine().setMaximumSpace(context)),
          Image.asset('assets/images/transparent_logo.png',
              width: BuzzooleSizingEngine().setThumbImageSize(context),
              height: BuzzooleSizingEngine().setThumbImageSize(context)),
          SizedBox(height: BuzzooleSizingEngine().setMaximumSpace(context)),
          DrawerMenuItem(
              icon: Icon(Icons.search),
              title: 'SEARCH FOR A MOVIE',
              route: '/search'),
          DrawerMenuItem(
              icon: Icon(Icons.list),
              title: 'MOVIE LIST',
              route: '/movie_list'),
          DrawerMenuItem(
              icon: Icon(Icons.watch), title: 'WATCHLIST', route: '/watchlist'),
          DrawerMenuItem(
              icon: Icon(Icons.favorite),
              title: 'FAVOURITES',
              route: '/favourite'),
          DrawerMenuItem(icon: Icon(Icons.logout), title: 'GOODBYE', route: '/')
        ],
      ),
    );
  }
}
