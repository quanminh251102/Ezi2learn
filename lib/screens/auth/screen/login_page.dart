// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import '../service/auth_service.dart';
// import '../../../main.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController email_controller = new TextEditingController();
//   final TextEditingController password_controller = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("MÀN HÌNH ĐĂNG NHẬP")),
//       body: SafeArea(
//         child: Column(children: [
//           TextField(
//             controller: email_controller,
//           ),
//           TextField(
//             controller: password_controller,
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               showDialog(
//                   context: context,
//                   barrierDismissible: false,
//                   builder: (context) => Center(
//                         child: CircularProgressIndicator(),
//                       ));
//               print("email : ${email_controller.text}");
//               print("password : ${password_controller.text}");
//               try {
//                 await AuthService.signIn(email_controller.text.trim(),
//                     password_controller.text.trim());
//               } on FirebaseAuthException catch (e) {
//                 print(e);
//               }

//               navigatorKey.currentState!.popUntil((route) => route.isFirst);
//             },
//             child: Text('Đăng nhập'),
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import './signup_page.dart';
import '../utils/colors.dart';
import '../widget/or_divider.dart';
import '../widget/social_icon.dart';

import '../widget/login_button.dart';
import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    void handleOnPressSignUpText() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpPage(),
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
              'Đăng nhập để tiếp tục',
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
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: isObscure
                              ? Image(
                                  image: const AssetImage('assets/images/eyeOff.png'),
                                  height: screenSize.height * 0.03,
                                  width: screenSize.width * 0.05,
                                )
                              : Image(
                                  image: const AssetImage('assets/images/eyeOn.png'),
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
            )),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              height: screenSize.height * 0.06,
              child: reusable_button(context, "Sign In", () async {
                // FirebaseAuth.instance
                //     .signInWithEmailAndPassword(
                //         email: emailController.text,
                //         password: passController.text)
                //     .then((value) {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => EntryPoint()));
                // }).onError((error, stackTrace) {
                //   print("Error ${error.toString()}");
                // });

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ));
                print("email : ${emailController.text}");
                print("password : ${passController.text}");
                try {
                  await AuthService.signIn(
                      emailController.text.trim(), passController.text.trim());
                } on FirebaseAuthException catch (e) {
                  print(e);
                }

                navigatorKey.currentState!.popUntil((route) => route.isFirst);
              }),
            ),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            Container(
              alignment: Alignment.center,
              child: const OrDivider(
                text: 'Hoặc đăng nhập với',
              ),
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
        padding: EdgeInsets.only(bottom: screenSize.height * 0.1),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Chưa có tài khoản? ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: handleOnPressSignUpText,
                child: Text(
                  'Đăng ký',
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
