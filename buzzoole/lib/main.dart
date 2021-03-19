import 'package:buzzoole/utils/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buzzoole Technical Test',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      onGenerateRoute: BuzzooleRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
