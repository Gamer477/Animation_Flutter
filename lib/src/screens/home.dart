import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget{
  HomeState createState()=> HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation;
  //كده عملنا declare للانيمشن ليس الا

  AnimationController catController;
  //و ديه برده declaration
  Animation<double> boxAnimation;
  AnimationController boxController;

  initState(){
    //ديه شغالة للكلاسات اللي ليها base من نوع State
    super.initState();

    boxController=AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation=Tween(begin: pi*0.6,end: pi*0.65)
    .animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );
    boxAnimation.addStatusListener((status){
      if(status==AnimationStatus.completed){
        boxController.reverse();
      }else if(status==AnimationStatus.dismissed){
        boxController.forward();
      }
    });
    boxController.forward();
    catController=AnimationController(
      duration: Duration(microseconds: 200),
      vsync: this,
    );
    catAnimation=Tween(begin: -35.0,end: -80.0)
      .animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }


onTap(){
    if(catController.status==AnimationStatus.completed){
      boxController.forward();
      catController.reverse();
    }else if(catController.status==AnimationStatus.dismissed){
      boxController.stop();
      catController.forward();//هتخلي االانميشن يشتغل
    }
}

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
       child:Center(
         child: Stack/*first in first out*/(
           overflow: Overflow.visible,
           children: [
             buildCatAnimation(),
             buildBox(),
             buildLeftFlap(),
             buildRightFlap(),
           ],
         ),
       ),
          onTap: onTap
      )
    );
  }
  Widget buildCatAnimation(){
     return AnimatedBuilder(
       animation: catAnimation,
       builder: (context,child){
          return Positioned(
            child: child,
            top: catAnimation.value,
            left:0.0 ,
            right: 0.0,
          );
       },
       child: Cat(),
     );

  }
  Widget buildBox(){
    return Container(
      width: 200.0,
      height: 200.0,
      color: Colors.brown,
    );
  }
  Widget buildLeftFlap(){
    return Positioned(
      left: 3.0,
      child:  AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context,child){
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      )
    );

  }
  Widget buildRightFlap(){
    return Positioned(
        right: 3.0,
        child:  AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
          builder: (context,child){
            return Transform.rotate(
              child: child,
              alignment: Alignment.topRight,
              angle: -boxAnimation.value,
            );
          },
        )
    );

  }
}