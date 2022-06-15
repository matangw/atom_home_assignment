import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_assignment/utils/notifications_services.dart';
import 'package:workmanager/workmanager.dart';
import '../../models/action.dart' as Actions;
import 'package:home_assignment/screens/home_screen/home_page_model.dart';
import 'package:home_assignment/screens/home_screen/home_page_view.dart';
import 'dart:math' as Math;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:shared_preferences/shared_preferences.dart';

class HomePageComponent extends StatefulWidget{
  @override
  State<HomePageComponent> createState() => _HomePageComponentState();
}

class _HomePageComponentState extends State<HomePageComponent> with SingleTickerProviderStateMixin implements HomePageView {

  late HomePageModel model;
  late final AnimationController _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
  NotificationsServices notificationsServices = NotificationsServices();

  //params:
  bool loading = true;
  //action params:
  bool rotate = false;

  @override
  void initState() {
    model = HomePageModel(this);
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(DateTime.wednesday.toString());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    notificationsServices.flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) => {
        print( value?.didNotificationLaunchApp.toString() ),
        if(value?.didNotificationLaunchApp==true){
          animation('animation')
        }
      });
    return Scaffold(
      body: loading? Container(height: height,width: width,child: const CircularProgressIndicator(),) : SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
           child: myButton(
                   height>width? height*0.1 : height*0.2,
                   height>width? width *0.6 : width*0.4
            ),

          ),
        ),
      ),
    );
  }


  Widget myButton(double height,double width){
    return InkWell(
      onTap: ()=>buttonPressed(),
      child:  AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * Math.pi,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: Duration(seconds: 3),
          onEnd: ()=> setState(()=>rotate=false),
          child: Container(
          height: height,
          width: width,
          color: Colors.blue,
          child: Center(
            child: Text(
              'PRESS',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
        ),
          ),
        ),
      );
  }

  @override
  void buttonPressed() {
    model.getButtonAction();
  }

  @override
  void loadAllData() {
    setState(()=>loading = false);
  }

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  void animation(String action) {
      SharedPreferences.getInstance().then((value) => value.setString(action, DateTime.now().toString()));
      _controller.forward();
  }

  @override
  Future<void> notification(String action) async{
    SharedPreferences.getInstance().then((value) => value.setString(action, DateTime.now().toString()));
    notificationsServices.showNotification(2, 'Action alert', 'Notification action executed', 5);

  }

  @override
  void toast(String action) {
    SharedPreferences.getInstance().then((value) => value.setString(action, DateTime.now().toString()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This is a toast')));
  }

  @override
  void noActionAvailable() {
   ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('NO ACTION AVAILABLE' ,style: TextStyle(color: Colors.white),),
         backgroundColor: Colors.red,
       ));
  }
}