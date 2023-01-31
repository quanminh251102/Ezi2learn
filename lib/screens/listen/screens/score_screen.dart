import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive_animation/screens/listen/screens/welcome_screen.dart';
import '../controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';
import '../../home/screen/home_page.dart' as NewHomePage;

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   QuestionController _qnController = Get.put(QuestionController());
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         children: [
  //           Spacer(flex: 3),
  //           Text(
  //             "Score",
  //             // style: Theme.of(context)
  //             //     .textTheme
  //             //     .headline3
  //             //     .copyWith(color: kSecondaryColor),
  //             style: TextStyle(color: kSecondaryColor),
  //           ),
  //           Spacer(),
  //           Text(
  //             "${_qnController.numOfCorrectAns * 10}/${_qnController.questions.length * 10}",
  //             // style: Theme.of(context)
  //             //     .textTheme
  //             //     .headline4
  //             //     .copyWith(color: kSecondaryColor),
  //             style: TextStyle(color: kSecondaryColor),
  //           ),
  //           Spacer(flex: 3),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => WelcomeScreen(),
  //                 ),
  //               );
  //             },
  //             child: Text('Trở về'),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    return Scaffold(
      body: Container(
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
                  'Điểm của bạn ${qnController.numOfCorrectAns * 10}',
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
                              const Text(
                                'Số câu đúng: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '${qnController.numOfCorrectAns}',
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
                              Text(
                                  '${qnController.questions.length - qnController.numOfCorrectAns}',
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
                        // for (var question in questionList) {
                        //   await db
                        //       .collection('questions')
                        //       .doc(question.text)
                        //       .update({'selectedOption': false});
                        //   await db
                        //       .collection('topics')
                        //       .doc(widget.topic.title)
                        //       .collection('vocabularies')
                        //       .doc(question.text)
                        //       .update({
                        //     'studied': true,
                        //   });
                        // }
                        // showDialog(
                        //   context: context,
                        //   builder: (_) => AssetGiffDialog(
                        //     image: Image.asset(
                        //       'assets/gif/warning.gif',
                        //       fit: BoxFit.contain,
                        //     ),
                        //     title: const Text(
                        //       'Wait!!!',
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //           fontSize: 22.0, fontWeight: FontWeight.w600),
                        //     ),
                        //     entryAnimation: EntryAnimation.bottomRight,
                        //     description: const Text(
                        //       'Nếu bạn làm lại điểm sẽ không được lưu, bạn chắc chứ ?',
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(fontSize: 14),
                        //     ),
                        //     buttonOkText: const Text(
                        //       'Làm lại',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     buttonCancelText: const Text(
                        //       'Quay lại',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     onCancelButtonPressed: () async {
                        //       Navigator.pop(context);
                        //     },
                        //     onOkButtonPressed: () {
                        //       // AchievenmentService.updatescrorewhenExit(
                        //       //     "Vocabulary", totalScore);
                        //       // Navigator.pop(context);
                        //       // Navigator.push(
                        //       //   context,
                        //       //   MaterialPageRoute(
                        //       //       builder: (context) => VocaMainScreen(
                        //       //             topic: widget.topic,
                        //       //           )),
                        //       // ).then((_) => setState(() {}));
                        //     },
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
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
                        // await db
                        //     .collection('topics')
                        //     .doc(widget.topic.title)
                        //     .update({
                        //   'progress': 1,
                        // });
                        // await db
                        //     .collection('topics')
                        //     .doc(widget.topic.title)
                        //     .update({'point': totalScore});
                        // for (var question in questionList) {
                        //   await db
                        //       .collection('topics')
                        //       .doc(widget.topic.title)
                        //       .collection('vocabularies')
                        //       .doc(question.text)
                        //       .update({
                        //     'studied': true,
                        //   });
                        // }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const VocaTopicScreen()),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewHomePage.HomePage(),
                          ),
                        );
                      },
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        "assets/icons/home.svg",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () async {
                    //     // await db
                    //     //     .collection('topics')
                    //     //     .doc(widget.topic.title)
                    //     //     .update({
                    //     //   'progress': 1,
                    //     // });
                    //     // await db
                    //     //     .collection('topics')
                    //     //     .doc(widget.topic.title)
                    //     //     .update({'point': totalScore});
                    //     // for (var question in questionList) {
                    //     //   await db
                    //     //       .collection('topics')
                    //     //       .doc(widget.topic.title)
                    //     //       .collection('vocabularies')
                    //     //       .doc(question.text)
                    //     //       .update({
                    //     //     'studied': true,
                    //     //   });
                    //     // }
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //       builder: (context) =>
                    //     //           const Scaffold(body: RankingScreen())),
                    //     // );
                    //   },
                    //   padding: EdgeInsets.zero,
                    //   icon: SvgPicture.asset(
                    //     "assets/icons/leaderboard.svg",
                    //   ),
                    // ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
