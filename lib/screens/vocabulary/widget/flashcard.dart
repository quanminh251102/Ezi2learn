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
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/background.png"), // <-- BACKGROUND IMAGE
            fit: BoxFit.contain,
          ),
        ),
      ),
      Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: SpeakerButton(
                      text: widget.vocabulary.text,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  width: 100,
                  child: Image.network(widget.vocabulary.image),
                ),
              ),
              Material(
                child: Text(
                  widget.vocabulary.text,
                  style: const TextStyle(
                      fontFamily: 'Intel',
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Material(
                child: Text(
                  widget.vocabulary.spelling,
                  style: const TextStyle(
                      fontFamily: 'Intel',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                child: Text(
                  widget.vocabulary.meaning,
                  style: const TextStyle(
                      fontFamily: 'Intel',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ]),
      ),
    ]);
    //
  }
}
