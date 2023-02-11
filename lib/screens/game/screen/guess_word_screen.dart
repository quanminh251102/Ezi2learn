import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:rive_animation/screens/game/screen/game_list_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rive_animation/screens/game/screen/guess_word_done_screen.dart';

import '../../vocabulary/model/topic.dart';

class GuessWordScreen extends StatefulWidget {
  const GuessWordScreen({super.key});

  @override
  State<GuessWordScreen> createState() => _GuessWordScreenState();
}

class _GuessWordScreenState extends State<GuessWordScreen> {
  bool isLoading = false;
  List<Topic> list = [];
  int currentIndex = 0;
  List<String> list_no_order = [];
  List<String> list_choose = [];
  final TextEditingController _controller = TextEditingController();
  double processValue = 0;
  GroupButtonController controllerGroupButton = GroupButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });

    final db = FirebaseFirestore.instance;
    QuerySnapshot vocaTopic = await db.collection('topics').get();

    list = vocaTopic.docs
        .map((doc) => Topic(
            title: '${doc['title']}',
            image: '${doc['image']}',
            progress: int.parse('${doc['progress']}'),
            point: int.parse('${doc['point']}'),
            done: '${doc['done']}' == 'true' ? true : false))
        .toList();

    setState(() {
      isLoading = false;
    });
    for (var item in list) {
      print(item.toJson());
    }
    init_quiz();
  }

  void init_quiz() {
    String topicName = list[currentIndex].title;

    list_no_order = [];
    list_choose = [];
    List<String> tempListNoOrder = [];
    List<String> tempListChoose = [];
    for (int i = 0; i < topicName.length; i++) {
      tempListNoOrder.add(topicName[i]);
    }
    tempListNoOrder.shuffle();

    setState(() {
      list_no_order = tempListNoOrder;
      processValue = currentIndex.toDouble() / list.length * 100;
    });

    controllerGroupButton.selectedIndexes.clear();
    _controller.text = "";
  }

  final player = AudioPlayer();

  bool check() {
    String stringChoice = "";
    for (var i in list_choose) {
      stringChoice += i;
    }

    if (stringChoice == list[currentIndex].title) {
      //Right
      player.play(AssetSource("audio/right_answer.mp3"));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your answer is correct')),
      );
      return true;
    } else {
      //wrong
      player.play(AssetSource("audio/wrong_answer.mp3"));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your answer is wrong')),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget pageBody = SizedBox(
      //color: Colors.green,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.network(
                  (list.isNotEmpty ? list[currentIndex].image : "")),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.8),
              child: TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                controller: _controller,
                //enabled: false,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01),
            child: GroupButton(
              controller: controllerGroupButton,
              options: GroupButtonOptions(
                selectedShadow: const [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 8),
                ],
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[900],
                ),
                selectedColor: Colors.pink[100],
                unselectedShadow: const [],
                unselectedColor: Colors.amber[100],
                unselectedTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
                selectedBorderColor: Colors.pink[900],
                unselectedBorderColor: Colors.amber[900],
                borderRadius: BorderRadius.circular(100),
                spacing: 10,
                runSpacing: 10,
                groupingType: GroupingType.wrap,
                direction: Axis.horizontal,
                buttonHeight: 60,
                buttonWidth: 60,
                mainGroupAlignment: MainGroupAlignment.center,
                crossGroupAlignment: CrossGroupAlignment.start,
                groupRunAlignment: GroupRunAlignment.start,
                textAlign: TextAlign.center,
                textPadding: EdgeInsets.zero,
                alignment: Alignment.center,
                elevation: 0,
              ),
              isRadio: false,
              onSelected: (string, index, isSelected) {
                print('$index  $string button is $isSelected');
                setState(() {
                  list_choose.add(string);
                  _controller.text += string;
                });
              },
              buttons: list_no_order,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () async {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => const MainPage()));
              //   // navigatorKey.currentState!
              //   //     .popUntil((route) => route.isFirst);
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text('Cập nhật thành công'),
              //     ),
              //   );
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Thông tin đã điền lổi')),
              //   );
              // }

              if (check() == true) {
                Future.delayed(const Duration(seconds: 2), () async {
                  int endQuiz = 6;
                  if (currentIndex + 1 == endQuiz) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GuessWordDoneScreen()));
                  } else {
                    currentIndex++;

                    init_quiz();
                  }
                });
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFFDA2C),
                shape: const StadiumBorder(),
                minimumSize: Size(
                  MediaQuery.of(context).size.width - 40,
                  50,
                )),
            child: const Text(
              'Check',
              style: TextStyle(
                color: Color.fromARGB(255, 87, 87, 87),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              init_quiz();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: const StadiumBorder(),
                minimumSize: Size(
                  MediaQuery.of(context).size.width - 40,
                  50,
                )),
            child: const Text(
              'Clear answer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameListScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(child: pageBody));
  }
}
