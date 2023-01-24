import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/auth/screen/login_page.dart';
import 'package:rive_animation/screens/auth/screen/splash_page.dart';
import 'package:rive_animation/screens/home/screen/home_screen.dart';
import 'package:rive_animation/screens/onboding/onboding_screen.dart';
import 'package:rive_animation/screens/pronunciation/screen/pronounciation_execute_service.dart';
import 'package:rive_animation/screens/pronunciation/screen/pronunciation_lesson.dart';
import 'package:rive_animation/screens/pronunciation/screen/record_speak.dart';
import 'package:rive_animation/screens/pronunciation/screen/record_speech_to_text.dart';
import 'package:rive_animation/screens/vocabulary/data/add_data.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';
import 'package:rive_animation/screens/vocabulary/widget/flashcard.dart';
import './screens/entry_point.dart';
import 'screens/home/screen/home_page.dart' as NewHomePage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyEnglishApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyEnglishApp extends StatelessWidget {
  const MyEnglishApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Ezi2learn',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      home: OnbodingScreen(),
      //home: SplashScreen(),
      //home: PronounciationExecuteService(),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            } else if (snapshot.hasData) {
              return NewHomePage.HomePage();
            } else {
              //return LoginPage();
              return OnbodingScreen();
            }
          }),
    );
  }
}
