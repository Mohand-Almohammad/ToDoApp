import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//صورة القفل 
Widget imgLock(double w, double h){
  return Center(     
    child: new Image.asset('assets/images/lock.jpg',
    height: h,
    width : w,
    fit: BoxFit.fill,
    ),
  );
}

//صورة الخلفية 
Widget imgBckg(double bW, double bH){
  return Center(
    child: new Image.asset('assets/images/bckgLogo.jpg',
      height: bH,
      width : bW,
      fit: BoxFit.fill,
    ),
  );
}

//Logo
Widget imgLogo(){
  return Center(     
    child: new Image.asset('assets/images/logo.jpg',
    height: 120.0,
    width : 115.0,
    fit: BoxFit.fill,
    ),
  );
}

