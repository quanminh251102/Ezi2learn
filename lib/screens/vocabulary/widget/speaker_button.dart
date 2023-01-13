import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class SpeakerButton extends StatefulWidget {
  const SpeakerButton({super.key, required this.text});
  final String text;
  @override
  State<SpeakerButton> createState() => _SpeakerButtonState();
}

class _SpeakerButtonState extends State<SpeakerButton> {
  bool buttonisPress = false;
  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    const backgroundColor = Color(0xffe7ecef);
    Offset distance =
        buttonisPress ? const Offset(20, 20) : const Offset(10, 10);
    double blur = buttonisPress ? 50 : 10;

    return Listener(
      onPointerUp: (_) {
        setState(() {
          buttonisPress = false;
        });
      },
      onPointerDown: (event) {
        setState(() {
          flutterTts.speak(widget.text);
          buttonisPress = true;
        });
      },
      child: AnimatedContainer(
        width: 40,
        height: 40,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: buttonisPress
                ? [
                    BoxShadow(
                      blurRadius: blur,
                      offset: distance,
                      color: Colors.white,
                      inset: buttonisPress,
                    ),
                    BoxShadow(
                      blurRadius: blur,
                      offset: -distance,
                      color: Colors.black,
                      inset: buttonisPress,
                    ),
                  ]
                : []),
        child: const Image(
          image: AssetImage(
            'assets/voca_quiz/listen_button.png',
          ),
        ),
      ),
    );
  }
}
