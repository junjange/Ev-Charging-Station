import 'package:ev_app/src/provider/bottom_navigation_provider.dart';
import 'package:ev_app/src/provider/count_provider.dart';
import 'package:ev_app/src/provider/ev_provider.dart';
import 'package:flutter/material.dart';
import 'package:ev_app/src/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
            // MultiProvider 통해 변화에 대해 구독
            providers: [
              ChangeNotifierProvider(
                  create: (BuildContext context) =>
                      CountProvider()), // count_provider.dart
              ChangeNotifierProvider(
                  create: (BuildContext context) => BottomNavigationProvider()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => EvProvider())
            ],
            child:
                Home() // home.dart // child 하위에 모든 것들은 Provider에 접근 할 수 있다.
            ));
  }
}
