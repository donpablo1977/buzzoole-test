import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/router.dart';
import 'package:buzzoole/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String _initialRoute = '/';
  if (_preferences.getString('username') != null) {
    _initialRoute = '/movie_list';
  }

  runApp(MyApp(initialRoute: _initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key key, @required this.initialRoute}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buzzoole Technical Test',
      theme: ThemeData(
          primarySwatch: BuzzooleUtils()
              .createMaterialColor(BuzzooleColors().buzzooleMainColor),
          primaryIconTheme:
              IconThemeData(color: BuzzooleColors().buzzooleMainColor),
          iconTheme: IconThemeData(color: BuzzooleColors().buzzooleMainColor)),
      onGenerateRoute: BuzzooleRouter.generateRoute,
      initialRoute: this.initialRoute,
    );
  }
}
