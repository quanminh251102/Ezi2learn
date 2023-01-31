import 'package:flutter/material.dart';
import '../constaints/constants.dart';
import './quiz_screen.dart';
import '../../home/screen/home_page.dart' as NewHomePage;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Listening Quiz',
        style: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewHomePage.HomePage(),
            ),
          );
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Spacer(flex: 2), //2/6
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Let's Play Quiz",
              // style: Theme.of(context).textTheme.headline4.copyWith(
              //     color: Colors.white, fontWeight: FontWeight.bold),
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "This quiz tests listening comprehension with conversational phrases.",
              style: TextStyle(
                color: Color.fromARGB(255, 119, 119, 119),
                fontSize: 18,
                //fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Instructions: Listen to the recorded question (person A), then select the best response (person B).',
              style: TextStyle(
                color: Color.fromARGB(255, 119, 119, 119),
                fontSize: 18,
                //fontWeight: FontWeight.w600,
              ),
            ),
            //
            // TextField(
            //   decoration: InputDecoration(
            //     filled: true,
            //     //fillColor: Color(0xFF1C2341),
            //     hintText: "Full Name",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(12)),
            //     ),
            //   ),
            // ),
            const Spacer(), // 1/6
            InkWell(
              //onTap: () => Get.to(QuizScreen()) ,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizScreen(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(kDefaultPadding * 0.75), // 15
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  //gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Text(
                  "Lets Start Quiz",
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .button
                  //     .copyWith(color: Colors.black),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2), // it will take 2/6 spaces
          ],
        ),
      ),
    );
  }
}
