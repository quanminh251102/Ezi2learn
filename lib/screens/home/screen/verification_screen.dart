import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/auth/screen/splash_page.dart';
import 'package:rive_animation/screens/home/screen/home_page.dart';

import '../../onboding/components/verification_form.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isVerified = false;
  Timer? timer;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isVerified) {
      await verification();
      timer = Timer.periodic(
          const Duration(seconds: 3), (timer) => checkVerified());
    }
    setState(() {
      isLoading = false;
    });
  }

  Future checkVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        setState(() {
          isVerified = true;
        });
        timer?.cancel();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future<void> verification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isVerified
      ? const HomePage()
      : Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
          ),
          //resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/email.png",
                  width: 100,
                  height: 100,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Xác minh email của bạn",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                VerificationForm(
                  verification: verification,
                ),
              ],
            ),
          ),
        );
}
