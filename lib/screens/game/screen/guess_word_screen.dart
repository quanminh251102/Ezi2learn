import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
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
  TextEditingController _controller = TextEditingController();
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
    List<String> temp_list_no_order = [];
    List<String> temp_list_choose = [];
    for (int i = 0; i < topicName.length; i++) {
      temp_list_no_order.add(topicName[i]);
    }
    temp_list_no_order.shuffle();

    setState(() {
      list_no_order = temp_list_no_order;
      processValue = currentIndex.toDouble() / list.length * 100;
    });

    controllerGroupButton.selectedIndexes.clear();
    _controller.text = "";
  }

  final player = AudioPlayer();

  bool check() {
    String string_choice = "";
    for (var i in list_choose) string_choice += i;

    if (string_choice == list[currentIndex].title) {
      //Right
      player.play(AssetSource("audio/right_answer.mp3"));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Câu trả lời của bạn chính xác')),
      );
      return true;
    } else {
      //wrong
      player.play(AssetSource("audio/wrong_answer.mp3"));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Câu trả lời của bạn sai')),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget pageBody = Container(
      //color: Colors.green,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: FAProgressBar(
                backgroundColor: const Color(0xffC4C4C4),
                changeProgressColor: const Color(0xffFFDA2C),
                progressColor: const Color(0xffFFDA2C),
                currentValue: processValue,
                displayText: '%',
                size: 20,
              )),
          SizedBox(
            width: 200,
            height: 200,
            child: Image.network(
                (list.length > 0 ? list[currentIndex].image : "")),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
            child: TextField(
              controller: _controller,
              //enabled: false,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          GroupButton(
            controller: controllerGroupButton,
            options: GroupButtonOptions(
              selectedShadow: const [],
              selectedTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.pink[900],
              ),
              selectedColor: Colors.pink[100],
              unselectedShadow: const [],
              unselectedColor: Colors.amber[100],
              unselectedTextStyle: TextStyle(
                fontSize: 20,
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
              mainGroupAlignment: MainGroupAlignment.start,
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
          SizedBox(
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
                  int end_quiz = 6;
                  if (currentIndex + 1 == end_quiz) {
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
              'Kiểm tra',
              style: TextStyle(
                color: Color.fromARGB(255, 87, 87, 87),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
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
              'Làm lại',
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
                  builder: (context) => GameListScreen(),
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
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(child: pageBody));
  }
}
