import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/onboding/components/sign_in_form.dart';

import 'components/animated_btn.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Backgrounds/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 280,
                      child: Column(
                        children: const [
                          Text(
                            "Joy English is here for you!",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Nền tảng học tiếng Anh thông qua các trò chơi thú vị và hệ thống ngữ pháp dễ tiếp cận cho trẻ nhỏ.",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            minimumSize: Size(
                              200,
                              50,
                            )),
                        onPressed: () {
                          _btnAnimationController.isActive = true;

                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              setState(() {
                                isShowSignInDialog = true;
                              });
                              showsignInDialog(
                                context,
                                onValue: (_) {
                                  setState(() {
                                    isShowSignInDialog = false;
                                  });
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          'Bắt đầu',
                          style: TextStyle(color: Colors.black),
                        )),
                    // AnimatedBtn(
                    //   btnAnimationController: _btnAnimationController,
                    //   press: () {
                    //     _btnAnimationController.isActive = true;

                    //     Future.delayed(
                    //       const Duration(milliseconds: 800),
                    //       () {
                    //         setState(() {
                    //           isShowSignInDialog = true;
                    //         });
                    //         showsignInDialog(
                    //           context,
                    //           onValue: (_) {
                    //             setState(() {
                    //               isShowSignInDialog = false;
                    //             });
                    //           },
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                          "Gồm 10+ chủ đề từ vựng và ngữ pháp thú vị, giúp các bạn nhỏ tiếp cận với tiếng Anh theo gần gũi và tự nhiên nhất."),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
