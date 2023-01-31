import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';
import 'package:rive_animation/screens/vocabulary/widget/speaker_button.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key, required this.vocabulary});
  final Vocabulary vocabulary;

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  FlutterTts flutterTts = FlutterTts();
  bool buttonisPress = false;
  double volume = 10;
  void initSetting() async {
    await flutterTts.setVolume(volume);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffFFDA2C), width: 5)),
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
                      Text(
                        widget.vocabulary.text,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.vocabulary.spelling,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.vocabulary.meaning,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
    //
  }
}
