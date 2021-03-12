import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/Ressources/globals.dart';
import 'package:to_do_list/Ressources/const.dart';
import 'package:to_do_list/Ressources/ressources.dart';
import 'Widgets/widget.dart';
import 'Widgets/TextWidget.dart';
import 'Widgets/ImageWidget.dart';
import 'new_password.dart';

class ConfirmCode extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> new ConfirmCodeState();
}

class ConfirmCodeState extends State<ConfirmCode>{
  final TextEditingController codeController = TextEditingController();
  String errorText= '';

  void returnToEmail(){errorText=''; Navigator.pop(context);}

  void resentCode(){errorText=''; Navigator.pop(context);}

  void goToNewPassWord(){ 
    if(codeController.text.trim() != "" ){ 
      errorText='';
      Navigator.push(context, MaterialPageRoute(builder: (context) => NewPassWord()));
      tokenn = codeController.text;
      print(tokenn);
    }else{ 
      setState(() {
        errorText = "Field is empty !";
      });
    }
  } 

  @override
  Widget build(BuildContext context) {
    double paddingUnderRaisedBtn2 = mainHeight(context)*0.14;        //130/896
    return new Scaffold(
      backgroundColor: bckgColor,
      appBar: appBar(str_changPassword, returnToEmail),

      body:ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: paddingBeforTopImg(context)),),
              imgLock(imgWidth(context), imgHeight(context)),

              Padding(padding: EdgeInsets.only(top: paddingUnderImg(context)),),
              textWidget02('Enter the Code'),
              
              Padding(padding: EdgeInsets.only(top: paddingBeforField(context)),),
              Container(
                width  : widthTextField(context),
                //height : heightTextField(context),
                child  : textFieldWiget('Code Confirmation', codeController, false),
              ),

              errorText.trim()=='' ? Text('', style:TextStyle(fontSize: 0)) 
                                   : errorTextWidget(errorText),

              Padding(padding: EdgeInsets.only(top: paddingUnderField(context)),),
              raisedBtnWidget(str_send, goToNewPassWord),

              Padding(padding: EdgeInsets.only(top: paddingUnderRaisedBtn2),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textWidget01(str_didntgetcode),
                    inkWell('Resent the code', resentCode),
                  ],
                ),
            ],
          ),
        ],
      ) ,
    );  
  }    
}      