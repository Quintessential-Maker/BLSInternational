import 'package:flutter/material.dart';

class HelperWidget{
 static bigHeading(text){
    return Text(text,style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize:20,

    ),);
  }
 static normalHeading(text){
   return Text(text,style: TextStyle(
     fontSize:16,

   ),);
 }


}