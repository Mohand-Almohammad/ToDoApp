import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/const.dart';

//appBar
Widget appBar(String appBarWidget , Function appBarFun){
  return AppBar(
    leading: IconButton(icon:Icon(Icons.arrow_back_ios), onPressed: appBarFun,),
    title: Text('Change Password'),
    centerTitle: true,
    backgroundColor: txt1Color,
  );
}

//textFields
Widget textFieldWiget(String hintTextWidget,
                      TextEditingController controllerWidget,
                      bool obscureTextWidget){
  return Container(
    child: TextField(                                
        controller: controllerWidget,
        obscureText: obscureTextWidget,
        //maxLines: 2,
        decoration: InputDecoration(hintText: hintTextWidget,
                                    hintStyle: TextStyle(
                                      color: txt2Color,
                                      fontSize: 11.0,
                                    ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: txt2Color, width:1)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: txt2Color, width:1)
          ),
        ),
    ),
  );
}

//flatButton
Widget flatBtnWidget(String textWidget, Function onPressedFun){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      FlatButton(
        child: Text(
          textWidget,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 11),
        ),
        textColor: color_topTitle,
        onPressed: onPressedFun,
      ),
    ],
  );
}


//raisedButton
Widget raisedBtnWidget(String signTypeWidget, Function functionWidget){
  return Container(
    child: RaisedButton(
      onPressed: functionWidget,
      color: btnColor,
      textColor: Colors.white,
      elevation: 5.0,
      splashColor: color_topTitle,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(12.0),
      ),
      padding: new EdgeInsets.only(left:100.0, right: 100.0, top: 14.0, bottom:14.0),
      child: Text( signTypeWidget , style: TextStyle( fontSize: 20.0)),
    ),
  );
}

Widget alertDialogWidget(){
  return  AlertDialog(
    title: Icon(Icons.done, color: doneColor, size: 90.0, ),
    content: Text('Great Job', 
              style: TextStyle(color:btnColor, fontSize: 21.0,),
              textAlign: TextAlign.center,
            ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
  );
}

//raisedButtun Add +
Widget raisedBtnAdd(Function addMission){
  return RaisedButton(
    onPressed: addMission,
    color: btnColor,
    elevation: 5.0,
    splashColor: txt2Color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0),),
    child: Icon(Icons.add),
  );
}