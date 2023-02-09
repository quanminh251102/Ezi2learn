import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:group_button/group_button.dart';
import 'package:rive_animation/screens/vocabulary/model/question.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/screen/result_screen.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';
import 'package:rive_animation/screens/vocabulary/widget/quiz_card.dart';

import '../../home/service/achievenment_service.dart';

class VocaQuiz extends StatefulWidget {
  const VocaQuiz({super.key, required this.topic});
  final Topic topic;

  @override
  State<VocaQuiz> createState() => _VocaQuizState();
}

class _VocaQuizState extends State<VocaQuiz> {
//
  final player = AudioPlayer();
  int current_score = 0;
  int listQuestion = 0;
  bool isPressed = false;
  bool isLocked = false;
  bool correctAnswer = false;
  bool nextQuestion = false;
  int currentQuestion = 1;
  int amountofQuestion = 0;
  int index = 0;
  Color optionColor = const Color(0xffFFDA2C);
  List<String> listOption = [];
  List<Question> list = [];
  late PageController controller;
  final db = FirebaseFirestore.instance;
  Future<QuerySnapshot> getQuestion() async {
    QuerySnapshot querySnapshot = await db
        .collection('questions')
        .where('topic', isEqualTo: widget.topic.title)
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> getOption() async {
    QuerySnapshot querySnapshot = await db
        .collectionGroup('options')
        .where(
          'ruid',
        )
        .get();
    return querySnapshot;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: 0);
    player.play(AssetSource("audio/background.mp3"), volume: 40);
  }

  @override
  Widget build(BuildContext context) {
    //
    Future<QuerySnapshot> questions = getQuestion();
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double paddingNum = deviceWidth / 32;

    double answerButtonsWidth = deviceWidth * 0.45;
    Widget answerButtons = Positioned(
        height: 250,
        child: FutureBuilder(
          future: questions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              listQuestion = documents.length;
              List<Question> questionList = documents
                  .map((doc) => Question(
                      id: doc.id,
                      topic: doc['topic'],
                      text: doc['text'],
                      image: doc['image'],
                      isLocked: '${doc['isLocked']}' == 'true' ? true : false,
                      selectedOption:
                          '${doc['selectedOption']}' == 'true' ? true : false,
                      options: Map<String, bool>.from(doc['options'])))
                  .toList();
              list = questionList;
              for (var temp in questionList) {
                for (var element in temp.options.keys) {
                  listOption.add(element.toString());
                }
              }
              return AbsorbPointer(
                absorbing: isLocked,
                child: GroupButton(
                  options: GroupButtonOptions(
                    selectedShadow: const [],
                    selectedTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    selectedColor: optionColor,
                    unselectedShadow: const [],
                    unselectedColor: const Color(0xffFFDA2C),
                    unselectedTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    selectedBorderColor: Colors.black,
                    unselectedBorderColor: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    spacing:
                        deviceWidth - answerButtonsWidth * 2 - paddingNum * 2,
                    runSpacing: 10,
                    groupingType: GroupingType.wrap,
                    direction: Axis.horizontal,
                    buttonHeight: deviceHeight * 0.1,
                    buttonWidth: answerButtonsWidth,
                    mainGroupAlignment: MainGroupAlignment.spaceBetween,
                    crossGroupAlignment: CrossGroupAlignment.center,
                    groupRunAlignment: GroupRunAlignment.start,
                    textAlign: TextAlign.center,
                    textPadding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    elevation: 0,
                  ),
                  isRadio: true,
                  onSelected: (text, optionIndex, isSelected) async {
                    setState(() {
                      isLocked = true;
                    });
                    if (questionList[currentQuestion - 1].options[text] ==
                        true) {
                      setState(() {
                        nextQuestion = true;
                        optionColor = const Color(0xff49B0AB);
                        player.play(AssetSource("audio/correct.mp3"));
                        current_score = current_score + 10;
                        AchievenmentService.Update("Vocabulary");
                      });
                      await db
                          .collection('questions')
                          .doc(questionList[currentQuestion - 1].text)
                          .update({
                        'selectedOption': true,
                      });
                    } else {
                      setState(() {
                        optionColor = Colors.red;
                        nextQuestion = true;
                        player.play(AssetSource("audio/wrong.mp3"));
                      });
                      await db
                          .collection('questions')
                          .doc(questionList[currentQuestion - 1].text)
                          .update({
                        'selectedOption': false,
                      });
                    }
                  },
                  buttons: [
                    (listOption[index]),
                    (listOption[index + 1]),
                    (listOption[index + 2]),
                    (listOption[index + 3])
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('$snapshot.error');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Vocabulary Quiz',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Visibility(
              visible: nextQuestion,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: GestureDetector(
                    onTap: () {
                      if (currentQuestion < listQuestion) {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInExpo);
                        setState(() {
                          isLocked = false;
                          currentQuestion = currentQuestion + 1;
                          index = index + 4;
                          nextQuestion = !nextQuestion;
                          optionColor = const Color(0xffFFDA2C);
                          player.play(AssetSource("audio/background.mp3"));
                        });
                      }
                    },
                    child: currentQuestion < listQuestion
                        ? const Text(
                            'Next',
                            style: TextStyle(
                                color: Color(0xff49B0AB),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : InkWell(
                            onTap: () async {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VocaResultScreen(
                                          topic: widget.topic,
                                        )),
                              ).then((_) => setState(() {}));
                            },
                            child: const Text(
                              'Result',
                              style: TextStyle(
                                  color: Color(0xff49B0AB),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
              ),
            )
          ],
          leading: GestureDetector(
            onTap: () {
              if (currentQuestion < listQuestion) {
                showDialog(
                  context: context,
                  builder: (_) => AssetGiffDialog(
                    image: Image.asset(
                      'assets/gif/warning.gif',
                      fit: BoxFit.contain,
                    ),
                    title: const Text(
                      'Wait!!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    entryAnimation: EntryAnimation.bottomRight,
                    description: const Text(
                      'Nếu bạn thoát ra lúc này điểm sẽ không được lưu, bạn chắc chứ ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    buttonOkText: const Text(
                      'Tiếp tục',
                      style: TextStyle(color: Colors.white),
                    ),
                    buttonCancelText: const Text(
                      'Thoát',
                      style: TextStyle(color: Colors.white),
                    ),
                    onCancelButtonPressed: () async {
                      await db
                          .collection('topics')
                          .doc(widget.topic.title)
                          .update({
                        'progress': 2,
                      });
                      AchievenmentService.updatescrorewhenExit(
                          "Vocabulary", current_score);
                      player.stop();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    onOkButtonPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AssetGiffDialog(
                    image: Image.asset(
                      'assets/gif/welldone.gif',
                      fit: BoxFit.contain,
                    ),
                    title: const Text(
                      'Good!!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    entryAnimation: EntryAnimation.bottomRight,
                    description: const Text(
                      'Bạn vừa hoàn thành xong bài kiểm tra, bạn muốn xem lại kết quả chứ ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    buttonOkText: const Text(
                      'Xem kết quả',
                      style: TextStyle(color: Colors.white),
                    ),
                    buttonCancelText: const Text(
                      'Quay lại',
                      style: TextStyle(color: Colors.white),
                    ),
                    onOkButtonPressed: () async {
                      await db
                          .collection('topics')
                          .doc(widget.topic.title)
                          .update({
                        'progress': 1,
                      });
                      player.stop();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VocaResultScreen(
                                  topic: widget.topic,
                                )),
                      ).then((_) => setState(() {}));
                    },
                    onCancelButtonPressed: () async {
                      await db
                          .collection('topics')
                          .doc(widget.topic.title)
                          .update({
                        'progress': 1,
                      });
                      player.stop();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VocaTopicScreen()),
                      ).then((_) => setState(() {}));
                    },
                  ),
                );
              }
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: FutureBuilder<QuerySnapshot>(
                      future: questions,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          amountofQuestion = documents.length;
                          return PageView.builder(
                              controller: controller,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                List<Question> questionList = documents
                                    .map((doc) => Question(
                                        id: doc.id,
                                        topic: doc['topic'],
                                        text: doc['text'],
                                        image: doc['image'],
                                        isLocked: '${doc['isLocked']}' == 'true'
                                            ? true
                                            : false,
                                        selectedOption:
                                            '${doc['selectedOption']}' == 'true'
                                                ? true
                                                : false,
                                        options: Map<String, bool>.from(
                                            doc['options'])))
                                    .toList();
                                return Column(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffDBF9F8),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 2, color: Colors.black)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Topic: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(widget.topic.title,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    QuizCard(
                                      currentQuestion: currentQuestion,
                                      amountofQuestion: amountofQuestion,
                                      question: questionList[index],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05),
                                      child: answerButtons,
                                    ),
                                  ],
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text('$snapshot.error');
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
