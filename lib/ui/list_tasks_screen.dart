import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/Ressources/const.dart';
import 'package:to_do_list/Ressources/strings.dart';
import 'package:to_do_list/controller/task_controller.dart';
import 'package:to_do_list/models/task.dart';
//import 'package:to_do_list/ui/Widgets/widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'Widgets/drawer.dart';

class ListTaskScreen extends StatefulWidget {
  final isToday;
  const ListTaskScreen({Key key, this.isToday=true}) : super(key: key);
  @override
  _ListTaskScreenState createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController listGoingController  = new ScrollController();
  ScrollController listCmpController    = new ScrollController();
  ScrollController listGblCmpController = new ScrollController();
  bool adding = false;
  bool afterVisible = false;

  List<Task> uncompletedTasks = new List<Task>();
  List<Task>  completedTasks = new List<Task> ();
  var db = new TaskController();
  double highTask;
  double withIcon;
  double widthTask;
  
  double ongingHeight;
  double cmpTskHeight;
  double topColumn;
  double H; 

  List<Item> listNode = List<Item>();

  initState(){
   /* db.getOnGoingTask().then((listGng){
      list.forEach((t){
        listNode.add(Item(FocusNode(), TextEditingController()));
      });
      setState(() {
        uncompletedTasks= listGng;
      });   
    }); 

    db.getCompletedTask().then((listCmp){
      setState(() {
        completedTasks= listCmp;
      });     
    }); */
    init().whenComplete((){
      setState(() {
        
      });
        WidgetsBinding.instance.scheduleFrameCallback((callback){      
          listGblCmpController.animateTo(topColumn, 
                                        curve: Curves.easeInCirc, duration: Duration(milliseconds:600));
      });
    });
    super.initState();
  }
   init()async{
     if(widget.isToday)
     {
      await getOnging();
      await getCompleted();
     }
     else await getTomorrow();
   }
   getOnging()async{
     var val = await db.getOnGoingTask();
      setState(() {
            
            list.forEach((t){
              listNode.add(Item(FocusNode(), TextEditingController()));
            });
            uncompletedTasks = val;
          }); 
  }

  getCompleted()async{
   var val = await db.getCompletedTask();
   setState(() {
       completedTasks = val;
     });
  }

  getTomorrow()async{
    var val = await db.getTomorrowdTask();
    setState(() {
        listNode.add(Item(FocusNode(), TextEditingController()));
        uncompletedTasks = val;
      });
  }
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    listNode.forEach((item){
      item.node.dispose();
      item.txtController.dispose();
    });

    super.dispose();
  }
  

  actionBtn(index, img,{bool del=true, bool completed = false}){
     return Container(
                height: highTask,
                width : withIcon,               
                margin: EdgeInsets.only(top:11),
                child : FlatButton(
                padding: EdgeInsets.all(0),
                child :Image.asset('assets/images/$img', fit: BoxFit.fill,),
                  onPressed: ()async{
                      adding = false;

                      if(del){                //delete task
                         if(completed){
                           //delete completed task
                            bool state = await db.deleteTask(completedTasks[index].id);
                            if(state)
                              setState(() {
                                completedTasks.removeAt(index);
                              });
                         }
                         else{
                           //delete onGoinng task
                            bool state = await db.deleteTask(uncompletedTasks[index].id);
                            if(state)
                              setState(() {
                                uncompletedTasks.removeAt(index);
                                listNode.removeAt(index);    
                              });
                         }
                      }
                      else {
                        //restore onGoinng task
                        bool state = await db.moveFromListtoOthorTask(uncompletedTasks[index].id);
                        if(state)
                          setState(() {
                            uncompletedTasks.removeAt(index);
                            listNode.removeAt(index);        
                          });
                        
                      }                      
                    },
                )
              );
  }
  elemTask(pos,TextEditingController txtController,{checked:false, FocusNode focusNode}){
     String txt = txtController.text;
     if(adding && !checked && pos==uncompletedTasks.length-1 && txt =='New task $pos')
                      txtController.selection = TextSelection(
                        
                      baseOffset: 0,
                      extentOffset: txt.length,
                      );
     return  KeyboardVisibilityBuilder(builder: (context, visible) {
      if(!checked && !visible && afterVisible) 
      {
         if(pos==uncompletedTasks.length-1)
         {
           
             adding = false;
           
           db.addTask(txtController.text, widget.isToday).then((val){
              uncompletedTasks[pos].setId = val;
              uncompletedTasks[pos].setTitle =txtController.text;
           });
         }
      }
    if(visible)
     afterVisible = true;

    double checkWith = checked?26.2:20.2;
    return Container(
          width  : widthTask,
          height : highTask,   
          padding: EdgeInsets.only(left:18,),                    
          margin : EdgeInsets.only(top:11),
          decoration: BoxDecoration(
            color: color_task,                  //change here
            borderRadius: BorderRadius.all(Radius.circular(9.0)) 
          ),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right:9.8,),  
                height: checkWith,
                width : checkWith,
                child: !widget.isToday ?
                  Image.asset('assets/images/uncheck2.jpg')
                  :
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon:Image.asset(checked? 'assets/images/checkk.jpg' : 'assets/images/uncheck2.jpg'),
                    onPressed: ()async{
                        if(checked){
                            bool statut = await db.restoreTask(completedTasks[pos].id);
                            if(statut){
                              setState(() {                    
                                uncompletedTasks.add( completedTasks[pos]);
                                completedTasks.removeAt(pos);    

                                listNode.add(Item(FocusNode(), TextEditingController()));    
                              });
                              listGblCmpController.animateTo(ongingHeight, 
                                                            curve: Curves.easeInCirc, duration: Duration(milliseconds:800));
                              listGoingController.animateTo(ongingHeight, 
                                                            curve: Curves.easeInCirc, duration: Duration(milliseconds:800));
                            }
                        }
                        else{
                            bool statut = await db.toCompletedTask(uncompletedTasks[pos].id);
                            if(statut){
                              setState(() {            
                                completedTasks.add( uncompletedTasks[pos]);
                                uncompletedTasks.removeAt(pos);           
                                listNode.removeAt(pos);
                              });
                              listGblCmpController.animateTo(listGblCmpController.position.maxScrollExtent,//(ongingHeight+cmpTskHeight+1100, 
                                                            curve: Curves.easeInCirc, duration: Duration(milliseconds:800));
                              listCmpController.animateTo(cmpTskHeight, 
                                                            curve: Curves.easeInCirc, duration: Duration(milliseconds:800));
                        }                    
                      }
                    },
                  )
              ),
               
                   checked ||(!checked && (!adding || pos!=uncompletedTasks.length-1)) ?                  
               Flexible(
                  child: Text(txtController.text,
                        style: TextStyle(fontFamily:fntfuturaM, fontSize: 16, decoration:checked? TextDecoration.lineThrough : TextDecoration.none),
                      // overflow: TextOverflow.ellipsis,
                    ),
                )                  
                :
               Flexible(
                  child:FocusScope(
                    onFocusChange:(v){
                   
                   if(!v)
                   print('focus chenge: $v $pos');
                          if (checked)
                          completedTasks[pos].setTitle =txtController.text;
                          else uncompletedTasks[pos].setTitle =txtController.text;
                   } ,
                   child: TextField(   
                     controller: txtController, 
                     focusNode: focusNode,
                     textInputAction: TextInputAction.done,
                     style: TextStyle(fontFamily:fntfuturaM, fontSize: 16),
                     onChanged: (val){
                       if (checked)
                       completedTasks[pos].setTitle =txtController.text;
                       else uncompletedTasks[pos].setTitle =txtController.text;
                     }, 
                     onEditingComplete: (){
                       print('compleetttt: $pos');
                          if (checked)
                          completedTasks[pos].setTitle =txtController.text;
                          else uncompletedTasks[pos].setTitle =txtController.text;
                          listNode[pos].node.unfocus();
                     }, 
                                                     
                    decoration: InputDecoration(    
                          enabledBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: color_task),  
                    borderRadius: BorderRadius.all(Radius.circular(9.0)) 
                          ),  
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: color_task),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: color_task),
                          ),
                        )
                    ),
                 ),
               ),
            ],
          ),
        );
      });
   }
  @override
  Widget build(BuildContext context) {
   if(!adding)  afterVisible = false;
    double W = MediaQuery.of(context).size.width;
           H = MediaQuery.of(context).size.height;
      
           //topColumn = H * 0.34;
           topColumn = H * 0.27;
    double topDrawer = H * 0.03; //double topDrawer = H * 0.037;
    double imgHeigh  = 77.6;   //iconMenu
    double imgWidth  = 60.8;
    double dnthaveTeskHeigh = 104; //   115
    double dnthaveTeskWidth = 133; //   135

    double paddingBeforLeftRightField = W * 0.072; 
           highTask  = 53;
           widthTask = W - 60;
           withIcon  = W * 0.094;
    var nbElem = uncompletedTasks.length>2? uncompletedTasks.length/2+1:uncompletedTasks.length;
           ongingHeight = (53.0+11) * nbElem+49;            //H * 0.28;
           cmpTskHeight = (53.0+11) * (completedTasks.length/2+1)+49;
    
    double heightBody =  H-topColumn;
   /* if(uncompletedTasks.length>0||completedTasks.length>0)
    heightBody+=90;*/

    if(!widget.isToday)
    ongingHeight = H-topColumn;
    
    DateTime today = DateTime.now();
    if(!widget.isToday)
    today = today.add(Duration(days: 1));

    return Scaffold(
      backgroundColor: bckgColor,
      key: scaffoldKey,
      drawer: drawer(context),
      //floatinActionBtn
      
      body: SingleChildScrollView(
        controller: listGblCmpController,
        reverse: true,
        child: Column(
          children: <Widget>[
            //Padding(padding: EdgeInsets.only(top: 0),),
            Container(
              width: W,
              height: topColumn,
              child: Stack(
                children: <Widget>[
                 Container(                    
                    height: topColumn,
                    width: W,
                    child:  Image.asset('assets/images/squares.jpg',fit: BoxFit.fill), 
                  ),
                 Positioned(
                   top  : topDrawer,
                   //left: W*0.01,
                   child: IconButton(icon: Image.asset('assets/images/drawers.jpg',
                   //fit  : BoxFit.fill,
                   //height: H*0.029,
                   //width : W*0.11,
                   ),
                   onPressed: ()=> scaffoldKey.currentState.openDrawer()
                   )
                 ),
                 Padding(padding: EdgeInsets.all( 60),),//change this
                 Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Padding(padding: EdgeInsets.only(top:H*0.09)),
                       Text(widget.isToday? str_toDay : str_tomorrow,
                       style: TextStyle(color:color_topTitle, fontFamily:fntRoboto, fontSize: 19, fontWeight: FontWeight.bold),),
                       Padding(padding: EdgeInsets.only(top:11)),
                       Text(DateFormat('EEEE').format(today),
                       style: TextStyle(color:color_topTitle, fontFamily:fntRoboto, fontSize: 18,),),
                       Padding(padding: EdgeInsets.only(top:12)),
                       Text(DateFormat('dd - MM - yyyy').format(today), 
                       style: TextStyle(color:color_topTitle, fontFamily:fntRoboto, fontSize: 13,),),
                       Padding(padding: EdgeInsets.only(top:10)),
                     ],
                   ),)
              ]),
            ),
            Center(
              child:IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Image.asset('assets/images/addBtn.jpg', fit: BoxFit.cover,), 
                    onPressed: (){
                      adding = true;
                      setState(() {
                        listNode.add(Item(FocusNode(), TextEditingController()));
                        uncompletedTasks.add(Task('New task ${uncompletedTasks.length}', false, DateTime.now().toString(), null, ));
                        afterVisible = false;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          FocusScope.of(context)
                              .requestFocus(listNode[listNode.length - 1].node);
                        });                      
                      });
                      listGoingController.animateTo((uncompletedTasks.length-1)* (53.0+11), curve: Curves.easeInCirc, duration: Duration(milliseconds:800));
                      
                      //adding = true;
                    },
                  ),
            ),
            //Padding(padding: EdgeInsets.only(top: H*0.06),),
            Container(
              width  : W,
              height : heightBody,//H-topColumn+90,
              padding: EdgeInsets.all(0),
              child  : uncompletedTasks.length == 0 && completedTasks.length == 0 ?
              Center(
                child: Container(
                  height: dnthaveTeskHeigh,
                  width:  dnthaveTeskWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: imgHeigh,
                        width: imgWidth,
                        child: Image.asset('assets/images/iconMenu.jpg',)//change this
                      ),
                      Text(str_dontHaveTask, style: TextStyle(color: color_Text, fontSize: 13, height: 1, fontFamily: fntfutura),)
                    ],
                  ),
                ),
              )
              :
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal:paddingBeforLeftRightField),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: ongingHeight,
                        child: Column(                        
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.only(top:20)),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                str_uncompleted, 
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: fntfuturaM,
                                  color: btnColor                                  
                                ),
                               ),
                            ),
                            Padding(padding: const EdgeInsets.only(top:5)),
                            Expanded(
                              child: ListView.builder(
                                controller: listGoingController,
                                itemCount:uncompletedTasks.length ,
                                itemBuilder: ( BuildContext context, int index){
                                  listNode[index].txtController.text = uncompletedTasks[index].title; 
                                  var txt =  uncompletedTasks[index].title;
                                  bool lastElem = txt =='New task $index' && index==uncompletedTasks.length-1 ;
                                  

                                 return  Slidable(
                                            actionPane: SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.15,                                  
                                            secondaryActions: [     
                                                  actionBtn(index, 'repeat1.jpg', del:false),
                                                  actionBtn(index, 'deletee.jpg'), //change this                                                                           
                                                ],
                                            child:elemTask(index, listNode[index].txtController,  focusNode:listNode[index].node ),
                                  );
                                }                              
                              ),
                            ),
                          ],
                        ),
                      ),
                     
                      Container(
                        height: !widget.isToday? 0 : cmpTskHeight,
                        child: Column(                        
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.only(top:20)),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                str_completed, 
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: fntfuturaM,
                                  color: color_topTitle                                  
                                ),
                               ),
                            ),
                            Padding(padding: const EdgeInsets.only(top:5)),
                            Expanded(
                              child: ListView.builder(
                                controller: listCmpController,
                                itemCount:completedTasks.length ,
                                itemBuilder: ( BuildContext context, int index){
                                  TextEditingController txtController = TextEditingController(text: completedTasks[index].title); 
                                 return  Slidable(
                                            actionPane: SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.15,                                  
                                            secondaryActions: [     
                                               //   actionBtn( index, 'repeat.png',del:false, completed:true),
                                                  actionBtn( index, 'deletee.jpg',completed:true),                                                  
                                                ],
                                            child:elemTask(index, txtController, checked:true, )//),
                                  );
                                }
                              
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
   );
  }
}

class Item{
 FocusNode node;
 TextEditingController txtController;
 Item(this.node, this.txtController);
}



/*floatingActionButton: Container(
              height: !widget.isToday? 0 : 52,
              width: W,
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Image.asset('assets/images/addBtn.jpg', fit: BoxFit.cover,), 
                    onPressed: (){
                      setState(() {
                        listNode.add(Item(FocusNode(), TextEditingController()));
                        uncompletedTasks.add(Task('New task ${uncompletedTasks.length}', false, DateTime.now().toString(), null, ));
                        afterVisible = false;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          FocusScope.of(context)
                              .requestFocus(listNode[listNode.length - 1].node);
                        });                      
                      });
                      listGoingController.animateTo((uncompletedTasks.length-1)* (53.0+11), curve: Curves.easeInCirc, duration: Duration(milliseconds:800));
                      
                      adding = true;
                    },
                  ),
              )
            ),*/