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
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffDBF9F8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.black)),
        child: Center(
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
                  Align(
                      alignment: Alignment.topRight,
                      child: SpeakerButton(
                        text: widget.question.text,
                      )),
                ],
              ),
              Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  color: const Color(0xffDBF9F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: 120,
                  child: Image.network(widget.question.image),
                ),
              )),
            ],
          ),
        ),
      ),
    );
    //
  }
}
