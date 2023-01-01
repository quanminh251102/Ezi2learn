import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key, required this.vocabulary});
  final Vocabulary vocabulary;

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 280,
            height: 380,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xffFFDA2C), width: 4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Image.asset(
                          'assets/voca_quiz/listen_button.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                        color: Colors.yellow,
                        onPressed: () {
                          print("Click back button 2");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 100,
                        child: Image.network(widget.vocabulary.image),
                      ),
                    ),
                    Text(
                      widget.vocabulary.text,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.vocabulary.spelling,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.vocabulary.meaning,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFDA2C),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 30,
                              width: 100,
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '< Previous',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFDA2C),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 30,
                              width: 100,
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Next >',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
          Container(
            width: 250,
            height: 10,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                border: Border.all(color: const Color(0xffFFDA2C),width: 3)),
          )
        ],
      ),
    );
  }
}
