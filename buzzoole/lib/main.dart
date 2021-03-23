import 'package:buzzoole/utils/router.dart';
import 'package:buzzoole/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String _initialRoute = '/';
  // BuzzooleUtils().deleteSharedPreferences();
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
        primarySwatch: Colors.amber,
      ),
      onGenerateRoute: BuzzooleRouter.generateRoute,
      initialRoute: this.initialRoute,
    );
  }
}
