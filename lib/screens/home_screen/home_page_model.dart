import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:home_assignment/screens/home_screen/home_page_view.dart';
import 'package:home_assignment/utils/general)utils.dart';
import 'package:intl/intl.dart';
import '../../models/action.dart';

class HomePageModel{

  List<Action> actions = [];
  HomePageView view;

  HomePageModel(this.view){
    getDataFromJsonFile();
  }


  Future<void> getDataFromJsonFile() async{
    final String response = await rootBundle.loadString('assets/json_file.json'); ///file name
    final data = await json.decode(response);
    getAllActions(data);
    view.loadAllData();
  }

  void getAllActions(var json){
    json.forEach((action){
      actions.add(Action.fromJson(action));
    });
  }


  void getButtonAction(){
    ///weekday filter
    List<Action> avialibleActions = actions.where((action) => action.validDays
        .contains(GeneralUtils().getDay(DateTime.now()))).toList();
    print('[!] VALID ACTIONS FOR DAY '+ GeneralUtils().getDay(DateTime.now()).toString() +': '
        + avialibleActions.length.toString());
    if(avialibleActions.isEmpty) {executeButtonAction();return;}


    ///enabled filter
    for(var action in avialibleActions){
      if(action.enabled==false){
        avialibleActions.remove(action);
      }
    }
    print('[!] ENABLED ACTIONS: '+ avialibleActions.length.toString());
    if(avialibleActions.isEmpty){executeButtonAction();return;}

    /// sort by priority
    avialibleActions.sort((a, b) => b.priority.compareTo(a.priority));
    print(avialibleActions[0].type);
    if(avialibleActions.isEmpty){executeButtonAction(); return;}

    executeButtonAction(action: avialibleActions[0]);

  }

  void executeButtonAction({Action? action}){
    if(action==null){
      return;
    }
    if(action.type=='animation'){
      view.animation();
    }
    if(action.type=='toast'){
      view.toast();
    }
    if(action.type=='notification'){
      view.notifaction();
    }
  }


  





}