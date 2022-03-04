import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:designs/src/pages/basico_page.dart';
import 'package:designs/src/pages/botones_page.dart';
import 'package:designs/src/pages/scroll_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños',
      initialRoute: 'botones',
      routes: {
        'basico': (BuildContext cotnext) => BasicoPage(),
        'scroll': (BuildContext cotnext) => ScrollPage(),
        'botones': (BuildContext cotnext) => BotonesPage(),
      },
    );
  }
}
