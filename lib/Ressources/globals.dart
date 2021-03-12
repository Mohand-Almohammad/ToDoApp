import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Size mainSize(BuildContext context){
  return MediaQuery.of(context).size;
}
//طول الواجهة
double mainHeight(BuildContext context){
  return mainSize(context).height;
}
//عرض الواجهة
double mainWidth(BuildContext context){
  return mainSize(context).width;
}
//عرض حقل الكتابة
double widthTextField(BuildContext context){
  return mainWidth(context)*0.71;                // 294/414
}
//طول حقل الكتابة
double heightTextField(BuildContext context){
  return mainHeight(context)*0.03;              // 26/896=0.029    29
}
//فوق حقل الكتابة
double paddingBeforTopField(BuildContext context){
  return mainHeight(context)*0.3;               //320/896   //315/896
}
//بين حقول الكتابة
double paddingBetweenFields(BuildContext context){
  return mainHeight(context)*0.05;               // 46.5/896
}
//فوق صورة القفل
double paddingBeforTopImg(BuildContext context){
  return mainHeight(context)*0.08;               // 75/896
}
double paddingUnderImg(BuildContext context){
  return mainHeight(context)*0.01;               // 15/896
}
//بين الزر و حقل الكتابة
double paddingUnderField(BuildContext context){
  return mainHeight(context)*0.14;                // 126/896
}
double paddingBeforField(BuildContext context){
  return mainHeight(context)*0.14;                // 132/896
}

double paddingBeforTopRaisedBtn(BuildContext context){
  return mainHeight(context)*0.07;                //67/896   //63.5/896
}
//
double imgWidth(BuildContext context){
  return mainWidth(context)*0.26;                 // 77.9/414=0.18    108
}
//
double imgHeight(BuildContext context){
  return mainHeight(context)*0.12;                // 108/896  
}
