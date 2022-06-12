import 'package:flutter/material.dart';

class Action{

  String type;
  bool enabled;
  int priority;
  List<int> validDays;
  int coolDown;

  Action({required this.coolDown,required this.enabled,required this.priority,required this.validDays,required this.type});


  factory Action.fromJson(Map<String,dynamic> json){
    return Action(
    coolDown: json['cool_down'],
    enabled: json['enabled'],
    priority: json['priority'],
    validDays: json['valid_days']==null ? [] : json['valid_days'].cast<int>(),
    type: json['type']);
  }




}