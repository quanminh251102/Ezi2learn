import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:rive_animation/screens/home/screen/ranking_screen.dart';
import 'package:rive_animation/screens/vocabulary/model/question.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_main.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';

import '../../home/service/achievenment_service.dart';

class VocaResultScreen extends StatefulWidget {
  const VocaResultScreen({super.key, required this.topic});
  final Topic topic;
  @override
  State<VocaResultScreen> createState() => _VocaResultScreenState();
}

class _VocaResultScreenState extends State<VocaResultScreen> {
  int completeQuestion = 0;
  int totalScore = 0;
  int rightAnswer = 0;
  int wrongAnswer = 0;
  final db = FirebaseFirestore.instance;
  Future<QuerySnapshot> getQuestion() async {
    QuerySnapshot querySnapshot = await db
        .collection('questions')
        .where('topic', isEqualTo: widget.topic.title)
        .get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getQuestion(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
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
          completeQuestion = questionList.length;
          for (var question in questionList) {
            if (question.selectedOption == true) {
              rightAnswer = rightAnswer + 1;
            }
          }
          wrongAnswer = questionList.length - rightAnswer;
          totalScore = 10 * rightAnswer;
          return Container(
            color: const Color(0xffFFDA2C),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Card(
                  shadowColor: Colors.black,
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.white,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        'assets/gif/congrats.gif',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      'Congrats !',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Điểm của bạn $totalScore',
                      style: const TextStyle(
                          fontSize: 28,
                          color: Color(0xffFFDA2C),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Số câu đã hoàn thành: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('$completeQuestion',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Số câu đúng: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '$rightAnswer',
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text('Số câu sai: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal)),
                                  Text('$wrongAnswer',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () async {
                            for (var question in questionList) {
                              await db
                                  .collection('questions')
                                  .doc(question.text)
                                  .update({'selectedOption': false});
                              await db
                                  .collection('topics')
                                  .doc(widget.topic.title)
                                  .collection('vocabularies')
                                  .doc(question.text)
                                  .update({
                                'studied': true,
                              });
                            }
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
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                entryAnimation: EntryAnimation.bottomRight,
                                description: const Text(
                                  'Nếu bạn làm lại điểm sẽ không được lưu, bạn chắc chứ ?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                ),
                                buttonOkText: const Text(
                                  'Làm lại',
                                  style: TextStyle(color: Colors.white),
                                ),
                                buttonCancelText: const Text(
                                  'Quay lại',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onCancelButtonPressed: () async {
                                  Navigator.pop(context);
                                },
                                onOkButtonPressed: () {
                                  AchievenmentService.updatescrorewhenExit(
                                      "Vocabulary", totalScore);
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VocaMainScreen(
                                              topic: widget.topic,
                                            )),
                                  ).then((_) => setState(() {}));
                                },
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            "assets/icons/redo.svg",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await db
                                .collection('topics')
                                .doc(widget.topic.title)
                                .update({
                              'progress': 1,
                            });
                            await db
                                .collection('topics')
                                .doc(widget.topic.title)
                                .update({'point': totalScore});
                            for (var question in questionList) {
                              await db
                                  .collection('topics')
                                  .doc(widget.topic.title)
                                  .collection('vocabularies')
                                  .doc(question.text)
                                  .update({
                                'studied': true,
                              });
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VocaTopicScreen()),
                            );
                          },
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            "assets/icons/home.svg",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await db
                                .collection('topics')
                                .doc(widget.topic.title)
                                .update({
                              'progress': 1,
                            });
                            await db
                                .collection('topics')
                                .doc(widget.topic.title)
                                .update({'point': totalScore});
                            for (var question in questionList) {
                              await db
                                  .collection('topics')
                                  .doc(widget.topic.title)
                                  .collection('vocabularies')
                                  .doc(question.text)
                                  .update({
                                'studied': true,
                              });
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Scaffold(body: RankingScreen())),
                            );
                          },
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            "assets/icons/leaderboard.svg",
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('$snapshot.error');
        }
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}
