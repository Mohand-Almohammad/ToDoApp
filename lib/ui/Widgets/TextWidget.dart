import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/const.dart';

Widget textWidget01(String textWidget01){
  return Text(
    textWidget01,
    style: TextStyle(fontSize: 11.0, color: txt1Color,),
  );
}

Widget textWidget02(textWidget02){
  return Text(
    textWidget02,
    style: TextStyle(fontSize: 11.0, color: color_topTitle),
    textAlign: TextAlign.center,
  );
}

Widget inkWell(String inkWellWidget , Function inkWellWidgetFun){
  return InkWell(
    onTap: inkWellWidgetFun,
    child: Text( inkWellWidget,
        style: TextStyle(
            color: color_topTitle,
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
      ),
    ),
  );
}

Widget errorTextWidget(String errorText1){
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: Text(errorText1, style: TextStyle(color: btnColor,),),
  );
}
