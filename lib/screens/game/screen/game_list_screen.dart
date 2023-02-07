import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/svg.dart';
import '../../home/screen/home_page.dart' as NewHomePage;
import './guess_word_screen.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  final controller = SwiperController();
  bool isPressed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.index = 1;
  }

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? Offset(1, 1) : Offset(4, 4);
    double blur = isPressed ? 5 : 10;
    Widget gameCard(String url, String title, Color iconColor) {
      return Container(
          height: 300,
          width: 300,
          margin: EdgeInsets.zero, //EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: const Color.fromARGB(96, 0, 0, 0),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.0)
                        ]),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 10),
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      GestureDetector(
                        onTap: () => setState(() {
                          isPressed = !isPressed;
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
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GuessWordScreen(),
                                ),
                              );
                            });
                          }
                        }),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellow.shade600,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: blur,
                                      offset: distance,
                                      color: const Color(0xFFA7A9AF),
                                      inset: isPressed),
                                  BoxShadow(
                                      blurRadius: blur,
                                      offset: -distance,
                                      color: const Color(0xFFA7A9AF),
                                      inset: isPressed),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset("assets/icons/play.svg"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text("Let's play game!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Swiper(
                      loop: false,
                      viewportFraction: 0.65,
                      scale: 0.6,
                      controller: controller,
                      itemCount: 3,
                      // onIndexChanged:
                      //     (int index) async {
                      //   await db
                      //       .collection('topics')
                      //       .doc(widget.topic.title)
                      //       .collection(
                      //           'vocabularies')
                      //       .doc(vocabularies[index]
                      //           .text)
                      //       .update({
                      //     'studied': true,
                      //   });
                      // },
                      itemBuilder: (context, index) {
                        return gameCard('assets/images/speaking.png',
                            'Guess word', Colors.grey);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
