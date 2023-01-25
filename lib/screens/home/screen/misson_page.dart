import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/game/screen/game_list_screen.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';

import '../../pronunciation/screen/pronunciation_lesson.dart';

class MissonPage extends StatefulWidget {
  const MissonPage({super.key});

  @override
  State<MissonPage> createState() => _MissonPageState();
}

class _MissonPageState extends State<MissonPage> {
  @override
  Widget build(BuildContext context) {
    Widget missionCard(String url, String title, Color iconColor) {
      return GestureDetector(
        onTap: () {
          //this.onCardClick!();
          if (title == "Speaking") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PronunciationLesson(),
              ),
            );
          } else if (title == "Vocabulary") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VocaTopicScreen(),
              ),
            );
          } else if (title == "Gaming") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameListScreen(),
              ),
            );
          }
        },
        child: Container(
            margin: EdgeInsets.zero, //EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 200,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(url, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color.fromARGB(96, 0, 0, 0),
                      // gradient: LinearGradient(
                      //     begin: Alignment.bottomCenter,
                      //     end: Alignment.topCenter,
                      //     colors: [
                      //       Colors.black.withOpacity(1.0),
                      //       Colors.transparent
                      //     ]),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipOval(
                            child: Container(
                          color: iconColor,
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.add_task,
                            color: Colors.white,
                          ),
                        )),
                        SizedBox(width: 10),
                        Text(title,
                            style: TextStyle(
                                color: Color.fromARGB(226, 255, 255, 255),
                                fontSize: 25))
                      ],
                    ),
                  ),
                )
              ],
            )),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: const Text('Thử Thách Hôm Nay',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SizedBox(
                        width: 250,
                        child: missionCard('assets/images/voca.jpg',
                            'Vocabulary', Colors.brown),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SizedBox(
                        width: 250,
                        child: missionCard('assets/images/speaking.png',
                            'Speaking', Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SizedBox(
                        width: 250,
                        child: missionCard('assets/images/dictionary.jpg',
                            'Listening', Colors.orange),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SizedBox(
                        width: 250,
                        child: missionCard('assets/images/dictionary.jpg',
                            'Gaming', Colors.orange),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: missionCard(
                    'assets/images/grammar.jpg', 'Grammar', Colors.green),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
