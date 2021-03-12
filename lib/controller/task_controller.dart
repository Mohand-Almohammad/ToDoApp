import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Ressources/ressources.dart';
import '../Ressources/strings.dart';
import '../models/task.dart';

List<Task> list = List<Task>();
class TaskController{
  String url = 'https://evening-earth-67130.herokuapp.com/api'; //https://todos-app-amb.herokuapp.com/api/task';
  bool status = false;
  String rsponseMsg = '';
  var response;

  Future<List<Task>> getOnGoingTask()async{
   String myUrl = '$url/tasks';
    list = List<Task>();
    try{
     response = await http.get(myUrl,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
      data["data"].forEach((task){
        list.add(Task.fromJson(task)); 
      });
    }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return list;
  }
  
  Future<List<Task>> getCompletedTask()async{
   String myUrl = '$url/done';
    list = List<Task>();
    status = false;
    rsponseMsg = '';
    try{
     response = await http.get(myUrl,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          );

    var data = json.decode(response.body);
    status =  data['success'];
    rsponseMsg = data['message'];
    if(status) 
    {
      data["data"].forEach((task){
        list.add(Task.fromJson(task)); 
      });
    }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return list;
  }


  Future<List<Task>> getTomorrowdTask()async{
    String myUrl = '$url/tomorrow';
    list = List<Task>();
    try{
     response = await http.get(myUrl,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
      data["data"].forEach((task){
        list.add(Task.fromJson(task)); 
      });
    }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return list;
  }

  Future<int> addTask(String task, bool isToday)async{
   String myUrl = '$url/tasks';
    int id;
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    if(!isToday)
    today =DateFormat("yyyy-MM-dd").format( DateTime.parse(today).add(Duration(days: 1)));
    try{
     response = await http.post(myUrl,
          headers: {
           // 'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          body: {
            "title" : task,
            "created": today
            }
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
      id = data["data"]["id"];
    }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return id;
  }

  Future<bool> toCompletedTask(id)async{
   String myUrl = '$url/done/$id';
   rsponseMsg ='';
   status = false;
    try{
     response = await http.delete(myUrl,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
    }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return status;
  }

  Future<bool> restoreTask(int id)async{
   String myUrl = '$url/restore/$id';
   rsponseMsg ='';
   status = false;
    try{
     response = await http.get(myUrl,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
    }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return status;
  }
  
  Future<bool> deleteTask(id)async{
   String myUrl = '$url/delete/$id';
   rsponseMsg ='';
   status = false;
    try{
     response = await http.delete(myUrl,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(!status) 
      rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return status;
  }

  Future<bool> moveFromListtoOthorTask(id)async{
   String myUrl = '$url/move/task/$id';
   rsponseMsg ='';
   status = false;
    try{
     response = await http.put(myUrl,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $global_token',
            }, 
          );

    var data = json.decode(response.body);
    status =  data['success'];
    if(status) 
    {
    }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return status;
  }


}