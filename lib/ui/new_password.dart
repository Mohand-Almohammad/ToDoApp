import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/globals.dart';
import 'package:to_do_list/Ressources/const.dart';
import 'package:to_do_list/Ressources/ressources.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/controller/dbHelper.dart';
import 'Widgets/widget.dart';
import 'Widgets/TextWidget.dart';
import 'Widgets/ImageWidget.dart';
import 'package:to_do_list/ui/list_tasks_screen.dart';

class NewPassWord extends StatefulWidget{

  NewPassWord({Key key, this.title}) : super(key : key);
  final String title;

  @override
  State<StatefulWidget> createState()=> new NewPassWordState();
}

class NewPassWordState extends State<NewPassWord>{
  
  DatabaseHelper databaseHelper = DatabaseHelper();
  //List<Task>  resetTask = new List<Task> ();

  final TextEditingController newPasswordController        = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  String errorText = '';
  String msgStatus = '';

  void returnToConfirmCode(){ Navigator.pop(context);} 
  void signUpFun03(){
    if(newPasswordController.text.trim()!='' && confirmNewPasswordController.text.trim()!=''){ 
      if(newPasswordController.text == confirmNewPasswordController.text){
        errorText='';
        databaseHelper.resetData(global_email,
                                 newPasswordController.text.trim(),
                                 confirmNewPasswordController.text.trim(),
                                 tokenn)
                    .whenComplete((){
                      if(!databaseHelper.status){
                        showDialog(
                          context: context, builder: (context){
                            Future.delayed(Duration(seconds: 1), (){
                              Navigator.of(context).pop(true);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ListTaskScreen()));
                            });
                          return alertDialogWidget();
                          }
                        );
                          
                     }else{
                        setState(() => msgStatus );
                     }
                    });
        
      }else{  
        setState(() => errorText = "Put the  same password" ); 
        }     
    }else{ 
      setState(() => errorText = "Field is empty !" );
    }
  }  

  @override
  Widget build(BuildContext context) {
    double paddingBeforRaisedBtn3 = mainHeight(context)*0.1;     //90/896
    double paddingUnderField3     = mainHeight(context)*0.11;        //104/896
    return new Scaffold(
      backgroundColor: bckgColor,
      appBar: appBar('Change Password', returnToConfirmCode),

      body:ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: paddingBeforTopImg(context)),),
              imgLock(imgWidth(context), imgHeight(context)),

              Padding(padding: EdgeInsets.only(top: paddingUnderImg(context)),),
              textWidget02('Enter a New Password'),
              
              Padding(padding: EdgeInsets.only(top: paddingUnderField3),),
              Container(
                width  : widthTextField(context),
                height : heightTextField(context),
                child  : textFieldWiget('New password', newPasswordController, true),
              ),
              Padding(padding: EdgeInsets.only(top: paddingBetweenFields(context)),),
              Container(
                width  : widthTextField(context),
                height : heightTextField(context),
                child  :textFieldWiget('Confirm password', confirmNewPasswordController, true),
              ),
              
              errorText.trim()=='' ? Text('', style:TextStyle(fontSize: 0)) 
                                   : errorTextWidget(errorText),
              msgStatus.trim()=='' ? Text('', style:TextStyle(fontSize: 0)) 
                                   : errorTextWidget(msgStatus),                     

              Padding(padding: EdgeInsets.only(top: paddingBeforRaisedBtn3),),
              raisedBtnWidget(str_confirm, signUpFun03),
            ],
          ),
        ],
      ) ,
    );
  }
}
