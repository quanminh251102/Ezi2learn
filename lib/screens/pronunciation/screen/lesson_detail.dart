import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rive_animation/screens/pronunciation/screen/finish_lesson.dart';
import 'package:rive_animation/screens/pronunciation/screen/pronunciation_lesson.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/pronounce_data.dart';

class LessonDetail extends StatefulWidget {
  final SpeakLesson speakLesson;

  LessonDetail({Key? key, required this.speakLesson}) : super(key: key);
  //LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  int _currentWord = -1;
  bool isCorrect = false;
  String state =
      "Hãy đọc tất cả các từ để phần mềm\n chấm điểm cho bạn chính xác nhất.";

  void reset() async {
    if (_currentWord + 1 == widget.speakLesson.words!.length) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishLesson(),
        ),
      );
    } else {
      setState(() {
        isCorrect = false;
        _current = 0;
        _currentWord++;
        _text = 'Nhấn nút bên dưới và bắt đầu nói';
        state = widget.speakLesson.words![_currentWord];
      });
      await speak(widget.speakLesson.words![_currentWord], 0.8);
      setState(() {
        state = "Đến lượt bạn";
      });
    }
  }

  // Begin : Speech To Text
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = 'Nhấn nút bên dưới và bắt đầu nói';
  double _confidence = 1.0;

  final player = AudioPlayer();

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
          state = "Mình đang nghe...";
        });
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            if (_text == widget.speakLesson.words![_currentWord]) {
              player.play(AssetSource("audio/right_answer.mp3"));
              setState(() {
                isCorrect = true;
                state = "Bạn đã phát âm chính xác";
              });
            } else {
              player.play(AssetSource("audio/wrong_answer.mp3"));
              setState(() {
                state = "Bạn đã phát âm sai";
              });
            }
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        if (state == "Mình đang nghe...") state = "Đến lượt bạn";
      });
      _speech!.stop();
    }
  }
  // End : Speech To Text

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    reset();
  }

  // Begin : Text To Speech
  bool isSpeaking = false;
  final FlutterTts flutterTts = FlutterTts();
  speak(String text, double speech) async {
    setState(() {
      isSpeaking = true;
    });
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speech);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      isSpeaking = false;
    });
  }
  // End : Text To Speech

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    const snackBar = SnackBar(
      content: Text(
        'Đã lưu từ vựng',
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            reverse: true,
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                          child: FAProgressBar(
                        backgroundColor: const Color(0xffC4C4C4),
                        changeProgressColor: const Color(0xffFFDA2C),
                        progressColor: const Color(0xffFFDA2C),
                        currentValue: _currentWord /
                            (widget.speakLesson.words!.length) *
                            100,
                        displayText: '%',
                        size: 20,
                      )),
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: CustomCard(
                        childPadding: 10,
                        width: deviceWidth,
                        height: 500,
                        borderRadius: 20,
                        color: Colors.white,
                        //overColor: Color.fromARGB(255, 248, 230, 149),
                        onTap: () {},
                        child: Column(
                          children: [
                            CustomCard(
                              borderRadius: 10,
                              childPadding: 4,
                              child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/5526/5526465.png"),
                                      backgroundColor: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      state,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 200,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.question_answer),
                            Text('Tra từ'),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (_current == 0) {
                            _controller.nextPage();
                            _current = 1;
                          } else {
                            _controller.previousPage();
                            _current = 0;
                          }
                        });
                      },
                    ),
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                          height: 50.0,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                            print("change ${index}");
                          }),
                      items: [1, 2].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              //decoration: BoxDecoration(color: Colors.amber),
                              child: (i == 1)
                                  ? ElevatedButton(
                                      onPressed: () {
                                        reset();
                                      },
                                      child: Text(
                                        'Tiếp theo',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: (isCorrect)
                                              ? Color(0xffFFDA2C)
                                              : Colors.grey,
                                          shape: StadiumBorder(),
                                          minimumSize: Size(
                                            MediaQuery.of(context).size.width +
                                                100,
                                            50,
                                          )),
                                    )
                                  : Card(
                                      child: Center(
                                          child: Text(
                                              'Dịch nghĩa : ${widget.speakLesson.meanings![_currentWord]}')),
                                    ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Positioned(
                  top: 350,
                  left: 110,
                  width: 200,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 0),
                    child: TextHighlight(
                      textAlign: TextAlign.center,
                      text: _text,
                      words: _highlights,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 200,
                    left: 147,
                    child: Column(
                      children: [
                        Text(
                          widget.speakLesson.words![_currentWord],
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            CustomCard(
                              borderRadius: 130,
                              child: Icon(
                                Icons.volume_up,
                                color:
                                    (isSpeaking) ? Colors.grey : Colors.black,
                              ),
                              onTap: () {
                                if (!isSpeaking)
                                  speak(widget.speakLesson.words![_currentWord],
                                      0.8);
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CustomCard(
                              borderRadius: 130,
                              child: Icon(
                                Icons.slow_motion_video,
                                color:
                                    (isSpeaking) ? Colors.grey : Colors.black,
                              ),
                              onTap: () {
                                if (!isSpeaking)
                                  speak(widget.speakLesson.words![_currentWord],
                                      0.01);
                              },
                            ),
                          ],
                        )
                      ],
                    )),
                Positioned(
                    top: 400,
                    left: (isSpeaking) ? 125 : 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: !isSpeaking,
                          child: CustomCard(
                            borderRadius: 130,
                            child: const Icon(Icons.hearing_rounded),
                            onTap: () {},
                          ),
                        ),
                        AvatarGlow(
                          animate: _isListening,
                          glowColor: Theme.of(context).primaryColor,
                          endRadius: 75.0,
                          duration: const Duration(milliseconds: 2000),
                          repeatPauseDuration:
                              const Duration(milliseconds: 100),
                          repeat: true,
                          child: FloatingActionButton(
                            backgroundColor:
                                (isSpeaking) ? Colors.grey : Color(0xffFFDA2C),
                            onPressed: _listen,
                            child: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isSpeaking,
                          child: CustomCard(
                            borderRadius: 130,
                            child: const Icon(Icons.bookmark),
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            )));
  }
}
