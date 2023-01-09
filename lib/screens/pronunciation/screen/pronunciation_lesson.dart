import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rive_animation/screens/pronunciation/screen/lesson_detail.dart';
import '../data/pronounce_data.dart';

class PronunciationLesson extends StatefulWidget {
  const PronunciationLesson({super.key});

  @override
  State<PronunciationLesson> createState() => _PronunciationLessonState();
}

class _PronunciationLessonState extends State<PronunciationLesson> {
  @override
  Widget build(BuildContext context) {
    Widget temp(int index, SpeakLesson item) {
      return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (index % 2 == 1)
              ? const Color(0xffFFDA2C)
              : Color.fromARGB(255, 248, 230, 149),
        ),
        child: ListTile(
          title: Text(item.title!),
          subtitle: Text(item.subTilte!),
          trailing: Icon(Icons.arrow_forward_ios),
          leading: Icon(
            Icons.speaker_notes,
            size: 30,
          ),
          onTap: () {
            print("hello");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonDetail(
                  speakLesson: item,
                ),
              ),
            );
          },
          onLongPress: () {
            print("long heelo");
          },
          iconColor: (index % 2 == 1) ? Colors.white : Colors.black,
          textColor: (index % 2 == 1) ? Colors.white : Colors.black,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Improve Pronuciation',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          //onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0), // here the desired height
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Center(
                    child: FAProgressBar(
                  backgroundColor: const Color(0xffC4C4C4),
                  changeProgressColor: const Color(0xffFFDA2C),
                  progressColor: const Color(0xffFFDA2C),
                  currentValue: 80,
                  displayText: '%',
                  size: 20,
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Level 3',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '54% - More 1250 pts to reach Level 4',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xff8A8A8A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            for (int i = 0; i < data.length; i++) temp(i, data[i])
          ]),
        ),
      ),
    );
  }
}
