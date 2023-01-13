import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';
import 'package:rive_animation/screens/vocabulary/widget/speaker_button.dart';

class QuizCard extends StatefulWidget {
  const QuizCard({super.key, required this.vocabulary});
  final Vocabulary vocabulary;

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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
              child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                color: const Color(0xffDBF9F8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 3),),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topRight,
                        child: SpeakerButton(
                          text: widget.vocabulary.text,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SizedBox(
                        width: 100,
                        child: Image.network(widget.vocabulary.image),
                      ),
                    ),
                  ]),
            ),
          )),
        ],
      ),
    );
    //
  }
}
