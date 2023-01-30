import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    _controller.reset();
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
                minimumSize: Size(
                  70,
                  30,
                ),
                maximumSize: Size(
                  70,
                  30,
                ),
              ),
              onPressed: _controller.nextQuestion,
              child: Text("Skip"),
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
      body: Body(),
    );
  }
}
