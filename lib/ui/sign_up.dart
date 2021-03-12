import 'package:flutter/material.dart';
import 'package:to_do_list/Ressources/ressources.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/Ressources/globals.dart';
import 'package:to_do_list/Ressources/const.dart';
import 'package:to_do_list/controller/dbHelper.dart';
import 'Widgets/widget.dart';
import 'Widgets/TextWidget.dart';
import 'Widgets/ImageWidget.dart';
import 'package:to_do_list/ui/list_tasks_screen.dart';
import 'package:to_do_list/ui/sign_in.dart';


class SignUp extends StatefulWidget{
  SignUp({Key key , this.title}) : super(key : key);
  final String title;

  @override
  State<StatefulWidget> createState()=> new SignUpState();
}

class SignUpState extends State<SignUp>{
  
  DatabaseHelper databaseHelper = DatabaseHelper();

  final TextEditingController nameController            = TextEditingController();
  final TextEditingController emailController           = TextEditingController();
  final TextEditingController passwordController        = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String errorText= '';

  void goToSignIn(){errorText='';
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn()));}        
  void signUpFun(){
   if(nameController.text.trim() !='' && emailController.text.trim() !='' && 
      passwordController.text.trim() !='' && confirmPasswordController.text.trim() !=''){ 

        if(passwordController.text == confirmPasswordController.text){
          databaseHelper.registerData(nameController.text.trim(), 
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      confirmPasswordController.text.trim())
                .whenComplete((){
                  if(databaseHelper.status){
                    setState(() => errorText = 'Check email or password');
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListTaskScreen()));
                    userName = nameController.text;
                    print(userName);
                  }});
          }else{
            setState(() => errorText = "Put the same password" );
          }
    }else{ 
      setState(() => errorText = "Field is empty !" );
    }
  }                               
  @override
  Widget build(BuildContext context) {
    double paddingBeforTopRaisedBtn2  = mainHeight(context)*0.07;    //63.5/896
    double paddingUnderRaisedBtn2     = mainHeight(context)*0.08;    //73/896

    return new Scaffold(
      backgroundColor: bckgColor,
       body: new Stack(
         children: <Widget>[
           Container(
            width  : mainWidth(context),
            height : mainHeight(context),
            child  : imgBckg(mainWidth(context), mainHeight(context)),
          ),

        new ListView(
          children: <Widget>[ 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ 
                Padding(padding: EdgeInsets.only(top: paddingBeforTopField(context)),),
                Container(
                  width : widthTextField(context),
                  height: heightTextField(context),
                  child :  textFieldWiget(str_name, nameController, false),
                ),
                Padding(padding: EdgeInsets.only(top: paddingBetweenFields(context)),),
                Container(
                  width : widthTextField(context),
                  height: heightTextField(context),
                  child :  textFieldWiget(str_email, emailController, false),
                ),
                Padding(padding: EdgeInsets.only(top: paddingBetweenFields(context)),),
                Container(
                  width : widthTextField(context),
                  height: heightTextField(context),
                  child : textFieldWiget(str_password, passwordController, true),
                ),
                Padding(padding: EdgeInsets.only(top: paddingBetweenFields(context)),),
                Container(
                  width : widthTextField(context),
                  height: heightTextField(context),
                  child :textFieldWiget(str_cPassword, confirmPasswordController, true),
                ),

                errorText.trim() == '' ? Text('', style:TextStyle(fontSize: 0)) 
                                       : errorTextWidget(errorText),

                Padding(padding: EdgeInsets.only(top: paddingBeforTopRaisedBtn2),),
                raisedBtnWidget(str_createAcc, signUpFun),

                Padding(padding: EdgeInsets.only(top: paddingUnderRaisedBtn2),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textWidget01(str_haveAcc),
                    inkWell(str_signIn, goToSignIn),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
   );
  }
}