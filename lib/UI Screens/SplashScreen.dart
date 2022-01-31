import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_book/UI%20Screens/Constants.dart';
import 'package:tailor_book/UI%20Screens/HomeScreen.dart';
import 'package:tailor_book/UI%20Screens/LoginScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatefulWidget {
  final bool isSeen;
  const Splash({Key? key,required this.isSeen}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1500,
      splash: 'assets/splash.png',
      nextScreen: widget.isSeen?HomeScreen():LoginScreen(),
      curve: Curves.easeIn,
    );
  }
}




