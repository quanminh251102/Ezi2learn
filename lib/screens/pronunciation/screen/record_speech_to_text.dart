import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

//import 'package:speech_to_text_example/main.dart';
//import 'package:speech_to_text_example/widget/substring_highlighted.dart';

//import '../utils.dart';
import '../api/speech_api.dart';

class RecordSpeechToText extends StatefulWidget {
  const RecordSpeechToText({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<RecordSpeechToText> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Record Speech To Text"),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(text);

                  // Scaffold.of(context).showSnackBar(
                  //   SnackBar(content: Text('✓   Copied to Clipboard')),
                  // );
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30).copyWith(bottom: 150),
          child: Text(text),
          // child: SubstringHighlight(
          //   text: text,
          //   terms: Command.all,
          //   textStyle: TextStyle(
          //     fontSize: 32.0,
          //     color: Colors.black,
          //     fontWeight: FontWeight.w400,
          //   ),
          //   textStyleHighlight: TextStyle(
          //     fontSize: 32.0,
          //     color: Colors.red,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 75,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            onPressed: toggleRecording,
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(const Duration(seconds: 1), () {
              //Utils.scanText(text);
            });
          }
        },
      );
}
