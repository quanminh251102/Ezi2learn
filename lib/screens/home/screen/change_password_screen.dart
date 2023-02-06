import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';

class ChangePassWordScreen extends StatefulWidget {
  const ChangePassWordScreen({super.key});

  @override
  State<ChangePassWordScreen> createState() => _ChangePassWordScreenState();
}

class _ChangePassWordScreenState extends State<ChangePassWordScreen> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController comfirmNewPassController = TextEditingController();
  bool isVisable_currentPass = true;
  bool isVisable_newPass = true;
  bool isVisable_confirmNewPass = true;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Change password',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: TextFormField(
                controller: currentPassController,
                obscureText: isVisable_currentPass,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: 'Current password',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: isVisable_currentPass
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
                        isVisable_currentPass = !isVisable_currentPass;
                      }),
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: TextFormField(
                controller: newPassController,
                obscureText: isVisable_newPass,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: 'New password',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: isVisable_newPass
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
                        isVisable_newPass = !isVisable_newPass;
                      }),
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: TextFormField(
                controller: comfirmNewPassController,
                obscureText: isVisable_confirmNewPass,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: 'Comfirm new password',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: isVisable_confirmNewPass
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
                        isVisable_confirmNewPass = !isVisable_confirmNewPass;
                      }),
                    )),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () async {
                print(currentPassController.text.trim());
                print(newPassController.text.trim());
                print(comfirmNewPassController.text.trim());

                if (newPassController.text.trim() ==
                    comfirmNewPassController.text.trim()) {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const MainPage()));

                  var currentUser = await FirebaseAuth.instance.currentUser;
                  await currentUser!
                      .updatePassword(newPassController.text.trim());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Updated password successfully!')),
                  );

                  currentPassController.text = '';
                  newPassController.text = '';
                  comfirmNewPassController.text = '';
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Your comfirm new password is not correct!')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffe482),
                  shape: const StadiumBorder(),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width - 40,
                    50,
                  )),
              child: Text(
                'Complete',
                style: TextStyle(
                  color: Color.fromARGB(255, 87, 87, 87),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
