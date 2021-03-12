import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/ressources.dart';
import 'package:to_do_list/controller/dbHelper.dart';
import 'package:to_do_list/ui/sign_in.dart';
//import 'Widgets/widget.dart';
import 'package:to_do_list/Ressources/const.dart';
import 'list_tasks_screen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> SplashScreenState(); 
}

class SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    timer();
  }

  timer() async {
    var duration = Duration(seconds: 1);
    return Timer(duration, route);
  }
  route()async{
    
  DatabaseHelper  db = DatabaseHelper();
  await db.readToken().then((v){
      if(global_token.trim() != '')
      Navigator.pushReplacement(context, MaterialPageRoute(
                                                      builder: (context) =>  ListTaskScreen(isToday:true)
                                                    ));
      else Navigator.pushReplacement(context, MaterialPageRoute(
                                                      builder: (context) => SignIn()
                                                    ));
      
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: bckgColor,
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Container(
              child: Image.asset('assets/images/logoWithText.jpg'),
            ),
          ],
        )
      )
    ); 
}}