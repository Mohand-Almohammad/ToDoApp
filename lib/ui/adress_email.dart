import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/globals.dart';
import 'package:to_do_list/Ressources/const.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/Ressources/ressources.dart';
import 'package:to_do_list/controller/dbHelper.dart';
import 'Widgets/widget.dart';
import 'Widgets/TextWidget.dart';
import 'Widgets/ImageWidget.dart';
import 'confirmation_code.dart';

class AdressEmail extends StatefulWidget{
  AdressEmail({Key key, this.title}) : super(key : key);
  final String title;

  @override
  State<StatefulWidget> createState() => new AdressEmailState();
}

class AdressEmailState extends State<AdressEmail>{
  DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController emailController = TextEditingController();
  String errorText= '';
  
  void returnToSignIn(){ 
    errorText= '';
    Navigator.pop(context);
  }
  void goToConfirmCode(){ 
    if(emailController.text.trim() !=""){
      errorText='';
      databaseHelper.forgetData(emailController.text.trim())
                    .whenComplete((){
                      if(databaseHelper.status){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmCode()));
                        global_email = emailController.text;
                        print(global_email);
                          
                     }else{
                        setState(() { errorText = 'Correct your email';});
                     }});
      }else{ 
        setState(() {
            errorText = "Field is empty !";
          });
      }
  }       

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: bckgColor,
      appBar: appBar(str_changePass, returnToSignIn),

      body:ListView(
        children: <Widget>[
          Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: paddingBeforTopImg(context)),),
              imgLock(imgWidth(context), imgHeight(context)),
              
              Padding(padding: EdgeInsets.only(top: paddingUnderImg(context)),),
              Container(
                width  : widthTextField(context),
                height : heightTextField(context),
                child  : textWidget02(str_enterEmail),
              ),
              
              Padding(padding: EdgeInsets.only(top: paddingBeforField(context)),),
              Container(
                width  : widthTextField(context),
                height : heightTextField(context),
                child  : textFieldWiget(str_adEmail, emailController, false),
              ),
              
              errorText.trim()=='' ? Text('', style:TextStyle(fontSize: 0)) 
                                   : errorTextWidget(errorText),                 

              Padding(padding: EdgeInsets.only(top: paddingUnderField(context)),),
              raisedBtnWidget(str_send, goToConfirmCode),
            ],
          ),
        ],
      ) ,
    );
  }
}