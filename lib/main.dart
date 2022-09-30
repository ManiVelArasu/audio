import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screen/audio.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter LoginPage',
      home: Homepage(),
      /*  home: HomePage(title: '',),*/
    );
  }
}

