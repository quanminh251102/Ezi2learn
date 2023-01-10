import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/home/home_screen.dart';
import 'package:rive_animation/screens/pronunciation/screen/pronunciation_lesson.dart';
import 'package:rive_animation/screens/pronunciation/screen/record_speak.dart';
import 'package:rive_animation/screens/pronunciation/screen/record_speech_to_text.dart';
import 'package:rive_animation/screens/vocabulary/data/add_data.dart';
import 'package:rive_animation/screens/vocabulary/data/voca_data.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_main.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';
import 'package:rive_animation/screens/vocabulary/voca_quiz.dart';
import 'package:rive_animation/screens/vocabulary/widget/flashcard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyEnglishApp());
}

class MyEnglishApp extends StatelessWidget {
  const MyEnglishApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: HomePage(),
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
