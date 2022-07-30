import 'package:flutter/material.dart';
import 'package:navigation_exap/page/memo_page.dart';
import 'package:navigation_exap/today_page/today_page.dart';

import 'page/add_page.dart';
import 'data/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => MemoPage(),
        "/addPage" : (context) => AddPage(),
        "/today" : (context) => TodayPage()
      },
    );
  }
}


