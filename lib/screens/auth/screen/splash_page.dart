import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/main.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:rive_animation/screens/onboding/onboding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    // Timer(const Duration(seconds: 4), (() {
    //   Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder: (_) => MainPage()), (route) => false);
    // }));
    // TODO: implement initState
    super.initState();

    player.play(AssetSource("audio/intro.mp3"));
  }

  @override
  void dispose() {
    player.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSplashScreen(
        splashIconSize: 250,
        //duration: 4000,
        //splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.white,
        nextScreen: OnbodingScreen(),
        splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      // color: Colors.amber,
                      height: screenSize.height * 0.3,
                      width: screenSize.width * 0.5,
                      child: Image.asset('assets/icons/phuong_icon.jpg')),
                ],
              )
            ]),
      ),
    );
  }
}
