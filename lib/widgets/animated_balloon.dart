import 'package:flutter/material.dart';

class AnimatedBalloonWidget extends StatefulWidget {
  const AnimatedBalloonWidget({super.key});

  @override
  State<AnimatedBalloonWidget> createState() => _AnimatedBalloonWidgetState();
}

class _AnimatedBalloonWidgetState extends State<AnimatedBalloonWidget> with TickerProviderStateMixin{

  late AnimationController _controllerFloatUp;
  late AnimationController _controllerGrowSize;
  late Animation<double> _animationFloatUp;
  late Animation<double> _animationGrowSize;

  @override
  void initState(){
    super.initState();

    _controllerFloatUp = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      );

    _controllerGrowSize = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      );
  }

  @override
  void dispose(){
    
    _controllerFloatUp.dispose();
    _controllerGrowSize.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double balloonHeight = MediaQuery.of(context).size.height / 2;
    double balloonWidth = MediaQuery.of(context).size.width / 2;
    double balloonBottomLocation = MediaQuery.of(context).size.height - balloonHeight; 

    _animationFloatUp = Tween(begin: balloonBottomLocation, end: 0.0).animate(CurvedAnimation(parent: _controllerFloatUp, curve: Curves.fastEaseInToSlowEaseOut));
    _animationGrowSize = Tween(begin: 50.0, end: balloonHeight).animate(CurvedAnimation(parent: _controllerGrowSize, curve: Curves.elasticInOut));

    _controllerFloatUp.forward();
    _controllerGrowSize.forward();

    return AnimatedBuilder(
      animation: _animationFloatUp,
      builder: (context, child){
        return Container(
          margin: EdgeInsets.only(top: _animationFloatUp.value),
          width: _animationGrowSize.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          if(_controllerFloatUp.isCompleted){
            _controllerFloatUp.reverse();
            _controllerGrowSize.reverse();
          }
          else{
            _controllerFloatUp.forward();
            _controllerGrowSize.reverse();
          }
        },
        child: Image.asset(
          'assets/images/Beginning-GoogleFlutter-Balloon.png',
          height: balloonHeight,
          width: balloonWidth,
          ),
      ),
      
    );
  }
}