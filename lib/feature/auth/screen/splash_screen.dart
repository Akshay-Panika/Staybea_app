import 'dart:async';
import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_logo.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const IntroScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          height: 200,width: 400,
          padding: EdgeInsets.all(75),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/intro/intro_card_bgi.png'),fit: BoxFit.fill)
          ),
          child: Image.asset(AppLogo.appLogo,),
        ),
      ),
    );
  }
}
