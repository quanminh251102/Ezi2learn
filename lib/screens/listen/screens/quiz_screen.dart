import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    controller.reset();
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 20, 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFFDA2C),
                shape: const StadiumBorder(),
                minimumSize: const Size(
                  70,
                  30,
                ),
                maximumSize: const Size(
                  70,
                  30,
                ),
              ),
              onPressed: controller.nextQuestion,
              child: const Text("Skip"),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(0, 12, 18, 0),
          //   child: CustomCard(
          //     borderRadius: 12,
          //     width: 60,
          //     height: 20,
          //     onTap: () {
          //       _controller.nextQuestion;
          //     },
          //     child: Center(
          //       child: Text(
          //         "Skip",
          //         style: TextStyle(
          //             color: Colors.black, fontWeight: FontWeight.w500),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      body: const Body(),
    );
  }
}
