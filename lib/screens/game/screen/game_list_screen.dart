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
    Offset distance = isPressed ? const Offset(1, 1) : const Offset(4, 4);
    double blur = isPressed ? 5 : 10;
    List<String> url = [
      'assets/images/game1.png',
      'assets/images/game2.png',
      'assets/images/game3.png'
    ];
    List<String> title = ['Bingo', 'World Puzzle', 'Matching'];
    List<Color> iconColor = [Colors.grey, Colors.grey, Colors.grey];
    Widget gameCard(String url, String title, Color iconColor) {
      return Stack(
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
              height: MediaQuery.of(context).size.height * 0.2,
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
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0.0)
                    ]),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 0),
                      child: Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ),
                    const Spacer(),
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
                        } else if (title == "World Puzzle") {
                          Future.delayed(const Duration(milliseconds: 100), () {
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
            ),
          )
        ],
      );
    }

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
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
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.08),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Let's have",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.normal)),
                      Text("SOME FUN!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset(
                      'assets/gif/game.gif',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
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
                  return gameCard(url[index], title[index], Colors.grey);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
