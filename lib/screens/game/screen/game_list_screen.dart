import 'package:flutter/material.dart';
import '../../home/screen/home_page.dart' as NewHomePage;
import './guess_word_screen.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  @override
  Widget build(BuildContext context) {
    Widget gameCard(String url, String title, Color iconColor) {
      return GestureDetector(
        onTap: () {
          //this.onCardClick!();
          if (title == "Speaking") {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PronunciationLesson(),
            //   ),
            // );
          } else if (title == "Vocabulary") {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => VocaTopicScreen(),
            //   ),
            // );
          } else if (title == "Guess word") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GuessWordScreen(),
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
                    decoration: const BoxDecoration(
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Text(title,
                                style: const TextStyle(
                                    color: Color.fromARGB(226, 255, 255, 255),
                                    fontSize: 25)),
                            Text(title,
                                style: const TextStyle(
                                    color: Color.fromARGB(226, 255, 255, 255),
                                    fontSize: 25)),
                          ],
                        ),
                        const SizedBox(width: 100),
                        ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFFDA2C),
                              shape: const StadiumBorder(),
                              minimumSize: const Size(
                                50,
                                30,
                              )),
                          child: const Text(
                            'Chơi ngay',
                            style: TextStyle(
                              color: Color.fromARGB(255, 87, 87, 87),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      );
    }

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      //elevation: 0,
      title: const Text(
        'Game',
        style: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewHomePage.HomePage(),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('Hãy chọn game để ôn tập',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 600,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: SizedBox(
                          width: 250,
                          child: gameCard('assets/images/voca.jpg',
                              'Vocabulary', Colors.brown),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: SizedBox(
                          width: 250,
                          child: gameCard('assets/images/speaking.png',
                              'Guess word', Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
