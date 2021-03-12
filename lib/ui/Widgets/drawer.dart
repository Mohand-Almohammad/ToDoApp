import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/globals.dart';
import 'package:to_do_list/Ressources/ressources.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/controller/dbHelper.dart';
import '../../Ressources/const.dart';

Widget drawer(BuildContext context ){
   double W = MediaQuery.of(context).size.width*0.77;
   double H = MediaQuery.of(context).size.height;

   double beforElem  = H * 0.15;
   double leftMargin = W * 0.14;
   double bwtElem    = H * 0.016;
   double afterElem  = H * 0.11;
   DatabaseHelper db = DatabaseHelper();
   
   return Container(    
           width: W,
           child: Drawer (     
                               
                    child: Stack(
                    
                      children: <Widget>[
                        Container(
                        color: btnColor,   ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding:  EdgeInsets.only(top:30),   ),
                            Container(
                              height: 128.8,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 85,  //80
                                      width : 82,   //65.4,//70
                                      child : Image.asset("assets/images/user.jpg",)
                                    ),
                                    Text(
                                      //userName,
                                      global_name,
                                      style: TextStyle(
                                        fontFamily: fntfuturaM,
                                        fontSize: 19,
                                        color:color_drawerTitle,
                                        height: 1
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: W,
                              margin: EdgeInsets.only(top: beforElem),
                              child: FlatButton(
                                padding:EdgeInsets.only(left:leftMargin,),
                                splashColor: color_drawerfocus,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                        str_toDay,
                                        style: TextStyle(
                                          fontFamily: fntfuturaM,
                                          fontSize: 13,
                                          color:color_drawerElem,
                                        ),
                                    ),
                                ),
                                onPressed:() => Navigator.of(context).pushReplacementNamed('/today'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top:bwtElem),
                              width: W,                               
                              child: FlatButton(
                                  padding:EdgeInsets.only(left:leftMargin,),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                          str_tomorrow,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: fntfuturaM,
                                            fontSize: 13,
                                            color:color_drawerElem,
                                          ),
                                      ),
                                  ),
                                  onPressed:() => Navigator.of(context).pushReplacementNamed('/tomorrow'),
                              ),
                            ),
                           
                            Container(
                              margin: EdgeInsets.only(top:bwtElem),
                              width: W,                               
                              child: FlatButton(
                                  padding:EdgeInsets.only(left:leftMargin,),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                          str_logOut,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: fntfuturaM,
                                            fontSize: 13,
                                            color:color_drawerElem,
                                          ),
                                      ),
                                  ),
                                  onPressed:() async{
                                     await db.logout(global_email).then((statut){                                          
                                        if(statut)
                                        Navigator.of(context).pushReplacementNamed('/login');
                                     });
                                  },
                              ),
                            ),  
                          ],
                        ),
                      ],
                    )
            )
          );
 }