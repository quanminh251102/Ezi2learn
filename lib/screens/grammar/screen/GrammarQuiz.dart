import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rive_animation/screens/grammar/screen/GrammarMain.dart';
import './FinishGrammar.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart'
    as CountDownIndicator;

class GrammarQuiz extends StatefulWidget {
  @override
  State<GrammarQuiz> createState() => _GrammarQuizState();

  final String step;
  const GrammarQuiz({super.key, required this.step});
}

class _GrammarQuizState extends State<GrammarQuiz> {
  final playerBackGround = AudioPlayer();
  final player = AudioPlayer();
  late int scroce = 0;
  late List<String> myChoices = [];
  late List<String> suggests = [];
  late List<String> anwsers = [];
  late List<String> quizs = [
    'I am a student in HCM city',
    'What is your name',
    'She is studying English',
    'He is playing game',
  ];

  late int current_quiz = 0;
  late int num_choice = 0;
  late GroupButtonController groupButtonController = GroupButtonController();
  late bool _isDisableCheck = true;

  final int _duration = 10;
  final CountDownIndicator.CountDownController _controller =
      CountDownIndicator.CountDownController();

  late bool _isStartQuiz = false;

  bool checkAnwser() {
    bool res = true;
    for (int i = 0; i < myChoices.length; i++) {
      print("${suggests[i]} ${anwsers[i]}");
    }
    for (int i = 0; i < myChoices.length; i++) {
      if (myChoices[i].compareTo(anwsers[i]) != 0) {
        res = false;
        print("${myChoices[i]} ${anwsers[i]} ");
        break;
      }
    }
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.step == "1") {
      quizs = [
        'She gets up at 6 o’clock',
        'She doesn’t eat chocolate',
        'Does she eat pastries?',
        'She is a student',
        'She is not a teacher',
        'Is she a student?',
      ];
    }

    if (widget.step == "2") {
      quizs = [
        'She is watching TV now',
        'She is not doing his homework now',
        'Is she studying English?',
        'The children are playing football now',
        'Look! The child is crying',
      ];
    }

    if (widget.step == "3") {
      quizs = [
        'I have done my homework',
        'I haven’t done my homework',
        'Have you done your homework?',
        'I’ve done all my homework',
        'She has lived in Liverpool all her life',
      ];
    }

    if (widget.step == "4") {
      quizs = [
        'She has been running all day',
        'She has not been running all day',
        'Has she been running all day',
        'She has been learning English for 6 years',
      ];
    }

    if (widget.step == "5") {
      quizs = [
        'I saw Peter yesterday',
        'I didn’t go to school yesterday',
        'Did you visit Mary last week?',
        'I was tired yesterday',
        'The supermarket was not full yesterday',
        'Were you absent yesterday?',
      ];
    }

    if (widget.step == "6") {
      quizs = [
        'He is playing game6',
        'She was watching TV at 8 o’clock last night',
        'She wasn’t watching TV at 8 o’clock last night',
        'Was she watching TV at 8 o’clock last night?',
        'I was having dinner at 7 o’clock last night',
        'I was watching TV when she called',
      ];
    }

    if (widget.step == "7") {
      quizs = [
        'By 4pm yesterday, he had left his house',
        'By 4pm yesterday, he had not left his house',
        'Had he left his house by 4pm yesterday',
        'By 4pm yesterday she had left his house',
        'Before she went to bed, she had done her homework',
      ];
    }

    if (widget.step == "8") {
      quizs = [
        'He had been watching films',
        'He hadn’t been watching film',
        'Had he been watching films?',
      ];
    }

    if (widget.step == "9") {
      quizs = [
        'I think It will rain',
        'I will bring coffee to you',
        'I will never speak to you again',
        'If you don’t hurry, you will be late',
      ];
    }

    if (widget.step == "10") {
      quizs = [
        'She will be climbing on the mountain at this time next Saturday',
        'The party will be starting at nine o’clock',
      ];
    }

    if (widget.step == "11") {
      quizs = [
        'I will have finished my homework by 9 o’clock',
        'They will have not built their house by the end of this month',
        'Will you have finished your homework by 9 o’clock?',
      ];
    }

    if (widget.step == "12") {
      quizs = [
        'We will have been living in this house for 10 years by next month',
        'We will not have been living in this house for 10 years by next month',
        'Will they have been building this house by the end of this year?',
      ];
    }

    init_quiz();
    playerBackGround.play(AssetSource("audio/countdown.mp3"));
    playerBackGround.setReleaseMode(ReleaseMode.loop);
  }

  void init_quiz() {
    num_choice = 0;

    anwsers = quizs[current_quiz].split(' ');

    suggests = List.from(anwsers);
    suggests.sort();

    myChoices = List.filled(anwsers.length, '__');
    groupButtonController = GroupButtonController(
      selectedIndexes: [],
    );

    _isDisableCheck = true;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      // title: const Text(
      //   'Ngữ pháp',
      //   style: TextStyle(
      //       color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      // ),
      leading: GestureDetector(
        onTap: () {
          player.stop();
          playerBackGround.stop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GrammarMainPage(),
            ),
          );
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: (_isStartQuiz == true)
          ? SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: FAProgressBar(
                        backgroundColor: const Color(0xffC4C4C4),
                        changeProgressColor: const Color(0xffFFDA2C),
                        progressColor: const Color(0xffFFDA2C),
                        currentValue:
                            ((current_quiz).toDouble() / quizs.length) * 100,
                        displayText: '%',
                        size: 16,
                      ),
                    ),
                    CustomCard(
                      color: Colors.white,
                      borderRadius: 10,
                      height: 281,
                      width: width - 24 - 24,
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(8),
                          child: GroupButton(
                            options: const GroupButtonOptions(
                              unselectedColor: Colors.white,
                              unselectedBorderColor: Colors.white,
                              elevation: 0,
                            ),
                            isRadio: false,
                            onSelected: (shocie, index, isSelected) {
                              print('$index button is selected');
                            },
                            maxSelected: 0,
                            buttons: myChoices,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: CountDownIndicator.CountDownProgressIndicator(
                        controller: _controller,
                        valueColor: const Color(0xffFFDA2C),
                        backgroundColor: Colors.grey[200]!,
                        initialPosition: 0,
                        duration: 30,
                        timeFormatter: (seconds) {
                          return Duration(seconds: seconds)
                              .toString()
                              .split('.')[0]
                              .padLeft(8, '0');
                        },
                        // text: 'hh:mm:ss',
                        onComplete: () {
                          setState(() {
                            if (checkAnwser() == true) {
                              scroce++;
                            }

                            if (current_quiz < quizs.length) {
                              current_quiz++;
                              if (current_quiz == quizs.length) {
                                print("Your sroce : $scroce");
                                player.stop();
                                playerBackGround.stop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FinishGrammar(
                                              sroce: (100.0 * scroce) /
                                                  quizs.length,
                                            )));
                              }
                              init_quiz();
                              _controller.restart(initialPosition: 0);
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GroupButton(
                      options: const GroupButtonOptions(
                        unselectedColor: Colors.white,
                        unselectedBorderColor: Colors.white,
                        selectedColor: Colors.black26,
                        elevation: 0,
                      ),
                      controller: groupButtonController,
                      isRadio: false,
                      onSelected: (strChoice, index, isSelected) {
                        print('$isSelected ${suggests[index]}');
                        if (isSelected == true) {
                          setState(() {
                            int pos = myChoices.indexOf('__');
                            myChoices[pos] = suggests[index];
                            num_choice++;
                            if (num_choice == anwsers.length) {
                              _isDisableCheck = false;
                            }
                            print(num_choice);
                          });
                        } else {
                          setState(() {
                            int pos = myChoices.indexOf(suggests[index]);
                            myChoices[pos] = '__';
                            num_choice--;
                            _isDisableCheck = true;
                          });
                        }
                      },
                      buttons: suggests,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        minimumSize: Size(width - 24 - 24, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          init_quiz();
                        });
                      },
                      child: const Text(
                        'Clear anwser',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFFDA2C),
                        minimumSize: Size(width - 24 - 24, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: _isDisableCheck
                          ? null
                          : () {
                              print('check');
                              bool check = checkAnwser();

                              // final snackBar = SnackBar(
                              //   /// need to set following properties for best effect of awesome_snackbar_content
                              //   elevation: 0,
                              //   behavior: SnackBarBehavior.floating,
                              //   backgroundColor: Colors.transparent,
                              //   content: AwesomeSnackbarContent(
                              //     title: (check == true) ? 'Đúng' : 'Sai',
                              //     message: '',

                              //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              //     contentType: (check == true)
                              //         ? ContentType.success
                              //         : ContentType.failure,
                              //   ),
                              // );

                              // ScaffoldMessenger.of(context)
                              //   ..hideCurrentSnackBar()
                              //   ..showSnackBar(snackBar);

                              if (check == true) {
                                player.play(
                                    AssetSource("audio/right_answer.mp3"));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Câu trả lời của bạn chính xác')),
                                );
                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() {
                                    scroce++;
                                    if (current_quiz < quizs.length) {
                                      current_quiz++;
                                      if (current_quiz == quizs.length) {
                                        print("Your sroce : $scroce");
                                        player.stop();
                                        playerBackGround.stop();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FinishGrammar(
                                                      sroce: (1.0 * scroce) /
                                                          quizs.length,
                                                    )));
                                      } else {
                                        init_quiz();
                                      }

                                      _controller.restart(initialPosition: 0);
                                    }
                                  });
                                });
                              } else {
                                player.play(
                                    AssetSource("audio/wrong_answer.mp3"));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Câu trả lời của bạn sai')),
                                );
                              }
                            },
                      child: const Text(
                        'Check',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularCountDownTimer(
                duration: 3,
                initialDuration: 0,
                controller: CountDownController(),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: const Color.fromARGB(255, 255, 226, 97),
                fillGradient: null,
                backgroundColor: const Color(0xffFFDA2C),
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                onComplete: () {
                  debugPrint('Countdown Ended');
                  setState(() {
                    _isStartQuiz = !_isStartQuiz;
                  });
                  playerBackGround.play(AssetSource("audio/background.mp3"));
                  playerBackGround.setReleaseMode(ReleaseMode.loop);
                },
                onChange: (String timeStamp) {
                  debugPrint('Countdown Changed $timeStamp');
                },
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  if (duration.inSeconds == 0) {
                    return "Start";
                  } else {
                    return Function.apply(defaultFormatterFunction, [duration]);
                  }
                },
              ),
            ),
    );
  }
}
