import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/Ressources/globals.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/Ressources/const.dart';
import 'Widgets/widget.dart';
import 'Widgets/TextWidget.dart';
import 'Widgets/ImageWidget.dart';
import 'adress_email.dart';
import 'package:to_do_list/ui/sign_up.dart';
import 'package:to_do_list/controller/dbHelper.dart';
import 'package:to_do_list/ui/list_tasks_screen.dart';

class SignIn extends StatefulWidget{
  SignIn({Key key, this.title}) : super(key : key);
  final String title;
  
  @override
  State<StatefulWidget> createState()=>  new SignInState(); 
}

class SignInState extends State<SignIn>{

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    if(value != '0'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ListTaskScreen()));
    }
  }

@override
initState(){
  //read();
  } 

  DatabaseHelper databaseHelper = DatabaseHelper();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorText= '';

  void forgetPassFun(){ Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdressEmail()));
                      } 
  void goToSignUp(){ Navigator.push(context,
                     MaterialPageRoute(builder: (context) => SignUp()));
                     } 

  void signInFun(){
    if(_emailController.text.trim() !="" && _passwordController.text.trim() !=""){ 
      errorText='';
      databaseHelper.loginData(_emailController.text.trim(), _passwordController.text.trim())
                    .whenComplete((){
                      if(databaseHelper.status){
                          setState(() => errorText = 'Check email or password' );
                     }else{
                       Navigator.push(context, MaterialPageRoute(builder:(context) => ListTaskScreen()));
                    }});
      }else{ 
        setState(() => errorText = "Field is empty !" );
      }
  }
  @override
  Widget build(BuildContext context) {
    double paddingBeforTopFlatBtn   = mainHeight(context)*0.01;       //16.5/896

    double paddingBeforTopRaisedBtn = mainHeight(context)*0.07;       //67/896
    double paddingUnderRaisedBtn    = mainHeight(context)*0.2;        //188/896


    return new Scaffold(
      backgroundColor: bckgColor,         //لون الخلفية
        body: new Stack(
         children: <Widget>[
          Container(
            width  : mainWidth(context),
            height : mainHeight(context),
            child  :imgBckg(mainWidth(context), mainHeight(context)),
          ),

          new ListView(
          children: <Widget>[ 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: paddingBeforTopField(context)),),

                Container(
                  width  : widthTextField(context),
                  height : heightTextField(context),
                  child  : textFieldWiget(str_email , _emailController, false),
                ),

                Padding(padding: EdgeInsets.only(top: paddingBetweenFields(context)),),
                Container(
                  width  : widthTextField(context),
                  height : heightTextField(context),
                  child  : textFieldWiget(str_password , _passwordController, true),
                ),

                errorText.trim()=='' ? Text('', style:TextStyle(fontSize: 0)) 
                                     : errorTextWidget(errorText),           
                               
                Padding(padding: EdgeInsets.only(top: paddingBeforTopFlatBtn),),
                flatBtnWidget(str_forgetPass, forgetPassFun),

                Padding(padding: EdgeInsets.only(top: paddingBeforTopRaisedBtn),),
                raisedBtnWidget(str_signIn, signInFun),

                Padding(padding: EdgeInsets.only(top: paddingUnderRaisedBtn),),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textWidget01(str_noAcc),
                    inkWell(str_createAcc, goToSignUp),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    )
   );
  }
}