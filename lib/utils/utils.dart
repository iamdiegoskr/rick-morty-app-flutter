
import 'package:flutter/material.dart';

class UtilApp{

  static Widget widgetStatusChatacter(String status){

    switch(status.toLowerCase()){
      case 'alive':{
        return Text('VIVO', style: statusColor(Colors.green));
      }
      case 'dead':{
        return Text('MUERTO', style: statusColor(Colors.red));
      }
      default:{
        return Text('DESCONOCIDO', style: statusColor(Colors.grey));
      }
    }

  }

  static TextStyle statusColor(Color statusColor){
  return TextStyle(color: statusColor, fontSize: 16,fontWeight: FontWeight.bold);
  }

  static String getGenderCharacter(String gender){
    switch(gender.toLowerCase()){
      case 'male':{
        return 'MASCULINO';
      }
      case 'female':{
        return 'FEMENINO';
      }
      default:{
        return 'IRRECONOCIBLE';
      }
    }
  }

  static String getSpecieCharacter(String specie){
    switch(specie.toLowerCase()){
      case 'alien':{
        return 'ALIENIGENA';
      }
      case 'human':{
        return 'HUMANO';
      }
      default:{
        return 'DESCONOCIDO';
      }
    }
  }

}