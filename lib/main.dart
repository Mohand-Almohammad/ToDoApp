import 'package:flutter/material.dart';
import 'package:to_do_list/ui/list_tasks_screen.dart';
import 'package:to_do_list/ui/sign_in.dart';
import 'package:to_do_list/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/today'    : (BuildContext context) => ListTaskScreen(isToday:true),
        '/tomorrow' : (BuildContext context) => ListTaskScreen(isToday:false),
        '/login'    : (BuildContext context) => SignIn(),
      },
    );
  }
}