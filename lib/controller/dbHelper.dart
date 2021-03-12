import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:to_do_list/Ressources/const.dart';
import 'package:to_do_list/Ressources/ressources.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/models/task.dart';

List<Task> list = List<Task>();

class DatabaseHelper{
  String mainUrl = "https://evening-earth-67130.herokuapp.com/api";
  var status ;          //false
  String msgStatus;
  var response;
  var data;
   loginData(String email, var password) async{
    String myUrl = "$mainUrl/login";
    status = true;
    msgStatus = '';
    final response = await http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "email"    : "$email",
          "password" : "$password"
        }
    );
    try{
        data = json.decode(response.body)["data"];
        status = response.body.contains('error'); //true رفض لوقن     false لايوجد مشكلة 

        if(status){
          print('data login : ${data["error"]}');
          msgStatus='error';
        }else{
          print('data d : ${data["token"]}');

          global_token = data["token"]; 
          global_name  = data["name"]; 
          global_email = email; 
          await _saveToken();
          msgStatus='';
       }
    }
    catch(e){
      status=true;
      msgStatus=e.toString();
    }
  }

   registerData(String name, String email, var password, var cPassword) async{
    String myUrl = "$mainUrl/register";
    //try{}
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name"      : "$name",
          "email"     : "$email",
          "password"  : "$password",
          "c_password": "$cPassword"
        } 
    );

    var data = json.decode(response.body);
    status = response.body.contains('error');

    if(status){
      print('data d : ${data["error"]}');
      
    }else{
      print('data d : ${data["token"]}');
      global_token = data["token"]; 
      global_name  = data["name"]; 
      global_email = email; 
      await _saveToken();
    }
  }



  forgetData(String email) async{
    String myUrl = "$mainUrl/forgot";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "email" : "$email",
        } 
    );

    var data = json.decode(response.body);
    //status = response.body.contains('error');
    status =  data['success'];

    if(status){
      print('data pass : ${data["success"]}');
    }else{

    }
  }
//الطريقة 1
  resetData(String email, var password, var cPassword, String _token) async{
    String myUrl = "$mainUrl/reset";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "email"     : "$email",
          "password"  : "$password",
          "c_password": "$cPassword",
          "token"     : "$_token",
        } 
    );

    var data = json.decode(response.body);
    status = response.body.contains('error');

    if(status){
      print('data reset : ${data["error"]}');
    }else{
      print('data reset : ${data["token"]}');
      
      global_email = email;
      global_name  = data["name"];
      global_token = data["token"];
      await _saveToken();
    }
  }

//الطريقة 2
  Future<List<Task>> resetTask(String _email, String _password, 
                               String _cPassword, String _token )async{
   String myUrl = '$mainUrl/reset';
   String _email , _password, _cPassword, _token ;
    list = List<Task>();
    try{
     response = await http.post(myUrl,
          headers: {
            'Accept':'application/json'
            }, 
          body: {
            "email"      : "$_email",
            "password"   : "$_password",
            "c_password" : "$_cPassword",
            "token"      : "$_token",
          }   
        );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
      data["data"].forEach((task){
        list.add(Task.fromJson(task)); 
      });
      print('data d task : ${data['success']}');
    }
    else 
    {
      msgStatus = data['msg'].toString();
      print(msgStatus);
    }
  }
  catch(e) {
    if (e.message.toString().contains('Failed host')){
        msgStatus =  e.toString() ;
        print(msgStatus);
     }else{msgStatus = e.message;
        print(msgStatus);
     }
    status = false;
  }   
  return list;
  }

  

  

  Future<List> getData() async{
    final prefs    = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final value    = prefs.get(keyToken) ?? 0;

    String myUrl = "$mainUrl/";        //change this
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept'        :'application/json',
          'Authorization' : 'Bearer $value'
    });
    return json.decode(response.body);
  }

  
  
 Future<bool> logout(String email)async{
   String myUrl = '$mainUrl/logout';
   msgStatus ='';
   status = false;
    try{
     response = await http.post(myUrl,
          headers: {
            'Accept':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          body: {
            "email" : email
          }
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
     await removeToken();
    }
    else msgStatus = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        msgStatus =  err_errConnexion ;
    else msgStatus = e.message;
    status = false;
  }   
  return status;
  }


  _saveToken() async {
    final prefs    = await SharedPreferences.getInstance();
    prefs.setString(shared_token, global_token);
    prefs.setString(shared_name, global_name);
    prefs.setString(shared_email, global_email);
  }

 readToken() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(shared_token))
    {
      global_token = prefs.getString(shared_token ) ?? '';
      global_name  = prefs.getString(shared_name ) ?? '';
      global_email = prefs.getString(shared_email ) ?? '';
    }
    else
    {
      global_token = '';
      global_name  = '';
      global_email = '';
    }

    print('read : $global_token $global_name $global_token');
    return global_token;
  }
  
 removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(shared_token );
    prefs.remove(shared_name );
    prefs.remove(shared_email );
    
  }


}