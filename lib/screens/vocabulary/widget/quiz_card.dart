import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rive_animation/screens/vocabulary/model/question.dart';
import 'package:rive_animation/screens/vocabulary/widget/speaker_button.dart';

class QuizCard extends StatefulWidget {
  const QuizCard(
      {super.key,
      required this.question,
      required this.currentQuestion,
      required this.amountofQuestion});
  final Question question;
  final int currentQuestion;
  final int amountofQuestion;

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  FlutterTts flutterTts = FlutterTts();
  bool buttonisPress = false;
  double volume = 10;
  void initSetting() async {
    await flutterTts.setVolume(volume);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/background_quiz.png"), // <-- BACKGROUND IMAGE
            fit: BoxFit.contain,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.06,
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                        'Question ${widget.currentQuestion} / ${widget.amountofQuestion}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: SpeakerButton(
                    text: widget.question.text,
                  ),
                ),
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.height * 0.3,
                height: MediaQuery.of(context).size.width * 0.35,
                child: Image.network(widget.question.image)),
          ],
        ),
      ),
    ]);
    //
  }
}
