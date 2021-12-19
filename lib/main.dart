import 'package:flutter/material.dart';
import 'pages/date.dart';
void main() {
  runApp(MaterialApp( home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DatePage(),
    );
  }
}

