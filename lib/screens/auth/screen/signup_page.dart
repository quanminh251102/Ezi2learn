import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/main.dart';

import '../utils/colors.dart';
import '../widget/login_button.dart';
import '../widget/or_divider.dart';
import '../widget/social_icon.dart';


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
                child: const Image(image: AssetImage('assets/images/res-logo.png'))),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          hintText: 'Email', border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  SizedBox(
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
                                        const AssetImage('assets/images/eyeOff.png'),
                                    height: screenSize.height * 0.03,
                                    width: screenSize.width * 0.05,
                                  )
                                : Image(
                                    image:
                                        const AssetImage('assets/images/eyeOn.png'),
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
                  SizedBox(
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
                                        const AssetImage('assets/images/eyeOff.png'),
                                    height: screenSize.height * 0.03,
                                    width: screenSize.width * 0.05,
                                  )
                                : Image(
                                    image:
                                        const AssetImage('assets/images/eyeOn.png'),
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
                      builder: (context) => const Center(
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
                        MaterialPageRoute(builder: (context) => const MainPage()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            Container(
              alignment: Alignment.center,
              child: const OrDivider(text: 'Hoặc đăng ký với'),
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
              const Text(
                'Đã có tài khoản? ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: handleOnPressLoginText,
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColor.mainColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
