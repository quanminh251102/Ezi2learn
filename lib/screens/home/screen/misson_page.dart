import 'package:flutter/material.dart';
import 'package:rive_animation/screens/game/screen/game_list_screen.dart';
import 'package:rive_animation/screens/grammar/screen/GrammarMain.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';

import '../../listen/screens/welcome_screen.dart';
import '../../pronunciation/screen/pronunciation_lesson.dart';

class MissonPage extends StatefulWidget {
  const MissonPage({super.key});

  @override
  State<MissonPage> createState() => _MissonPageState();
}

class _MissonPageState extends State<MissonPage> {
  @override
  Widget build(BuildContext context) {
    Widget missionCard(String url, String title, Color iconColor, String icon) {
      return GestureDetector(
        onTap: () {
          //this.onCardClick!();
          if (title == "Speaking") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PronunciationLesson(),
              ),
            );
          } else if (title == "Vocabulary") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VocaTopicScreen(),
              ),
            );
          } else if (title == "Gaming") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GameListScreen(),
              ),
            );
          } else if (title == "Grammar") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GrammarMainPage(),
              ),
            );
          } else if (title == "Listening") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
            );
          }
        },
        child: PhysicalModel(
            elevation: 10.0,
            shape: BoxShape.rectangle,
            shadowColor: Colors.black,
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
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
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: const Color.fromARGB(150, 0, 0, 0),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(1),
                              Colors.black.withOpacity(0.1)
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          ClipOval(
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Image(image: AssetImage(icon)))),
                          Text(title,
                              style: const TextStyle(
                                  color: Color.fromARGB(226, 255, 255, 255),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text("Today's challenge",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: missionCard(
                              'assets/images/voca.jfif',
                              'Vocabulary',
                              Colors.brown,
                              'assets/icons/vocabulary.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: missionCard(
                              'assets/images/speaking.png',
                              'Speaking',
                              Colors.grey,
                              'assets/icons/speaking.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: missionCard(
                              'assets/images/listening.jfif',
                              'Listening',
                              Colors.orange,
                              'assets/icons/listening.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: missionCard(
                              'assets/images/gaming.jfif',
                              'Gaming',
                              Colors.orange,
                              'assets/icons/gaming.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: missionCard('assets/images/grammar.png', 'Grammar',
                    Colors.green, 'assets/icons/reading.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
