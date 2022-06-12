import 'package:flutter/material.dart';
import 'package:home_assignment/screens/home_screen/home_page_model.dart';
import 'package:home_assignment/screens/home_screen/home_page_view.dart';
import 'dart:math' as Math;

class HomePageComponent extends StatefulWidget{
  @override
  State<HomePageComponent> createState() => _HomePageComponentState();
}

class _HomePageComponentState extends State<HomePageComponent> with SingleTickerProviderStateMixin implements HomePageView {

  late HomePageModel model;
  late final AnimationController _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));

  //params:
  bool loading = true;
  //action params:
  bool rotate = false;

  @override
  void initState() {
    model = HomePageModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(DateTime.wednesday.toString());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading? Container(height: height,width: width,child: const CircularProgressIndicator(),) : SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
           child: myButton(
                   height>width? height*0.1 : height*0.3,
                   height>width? width *0.6 : width*0.3
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
  void animation() {
      _controller.forward();
  }

  @override
  void notifaction() {
    print('notification');
  }

  @override
  void toast() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This is a toast')));
  }
}