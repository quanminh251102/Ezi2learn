import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rive_animation/screens/auth/screen/splash_page.dart';
import 'package:rive_animation/screens/home/screen/verification_screen.dart';
import 'package:rive_animation/screens/onboding/components/verification_form.dart';
import 'package:rive_animation/screens/onboding/onboding_screen.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'Ezi2learn',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEEF1F8),
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyMedium:
                GoogleFonts.sourceSansPro(textStyle: textTheme.bodyMedium),
          ),
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
        home: const MainPage());
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.hasData) {
              return const VerificationScreen();
            } else {
              return SplashScreen();
            }
          }),
      // body: SplashScreen(),
    );
  }
}
