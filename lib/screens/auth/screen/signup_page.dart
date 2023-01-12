import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive_animation/main.dart';
import 'package:rive_animation/screens/entry_point.dart';
import './login_page.dart';

import '../utils/colors.dart';
import '../widget/login_button.dart';
import '../widget/or_divider.dart';
import '../widget/social_icon.dart';

import '../../../main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    void handleOnPressLoginText() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    }

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              screenSize.width * 0.05,
              screenSize.height * 0.1,
              screenSize.width * 0.05,
              screenSize.height * 0.1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/images/res-logo.png'))),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            const Text(
              'Tạo tài khoản',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            Form(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'Email', border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: passController,
                      obscureText: isObscure,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: isObscure
                                ? Image(
                                    image:
                                        AssetImage('assets/images/eyeOff.png'),
                                    height: screenSize.height * 0.03,
                                    width: screenSize.width * 0.05,
                                  )
                                : Image(
                                    image:
                                        AssetImage('assets/images/eyeOn.png'),
                                    height: screenSize.height * 0.03,
                                    width: screenSize.width * 0.05,
                                  ),
                            onPressed: () => setState(() {
                              isObscure = !isObscure;
                            }),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      obscureText: isObscure,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: 'Xác nhận mật khẩu',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: isObscure
                                ? Image(
                                    image:
                                        AssetImage('assets/images/eyeOff.png'),
                                    height: screenSize.height * 0.03,
                                    width: screenSize.width * 0.05,
                                  )
                                : Image(
                                    image:
                                        AssetImage('assets/images/eyeOn.png'),
                                    height: screenSize.height * 0.03,
                                    width: screenSize.width * 0.05,
                                  ),
                            onPressed: () => setState(() {
                              isObscure = !isObscure;
                            }),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            Container(
                alignment: Alignment.center,
                height: screenSize.height * 0.06,
                child: reusable_button(context, "Sign Up", () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ));

                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text)
                      .then((value) {
                    print("Created New Account");
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            Container(
              alignment: Alignment.center,
              child: OrDivider(text: 'Hoặc đăng ký với'),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Container(
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: 'assets/images/apple.png',
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: 'assets/images/google.png',
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: 'assets/images/fb.png',
                    press: () {},
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: screenSize.height * 0.05),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đã có tài khoản? ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              InkWell(
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColor.mainColor),
                ),
                onTap: handleOnPressLoginText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
