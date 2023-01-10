import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive_animation/screens/pronunciation/screen/pronunciation_lesson.dart';
import 'package:audioplayers/audioplayers.dart';

class FinishLesson extends StatefulWidget {
  const FinishLesson({super.key});

  @override
  State<FinishLesson> createState() => _FinishLessonState();
}

class _FinishLessonState extends State<FinishLesson> {
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.play(AssetSource("audio/tada.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image(
              image: NetworkImage(
                  'https://thumbs.gfycat.com/FarawayTestyChimneyswift-max-1mb.gif'),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Chúc mừng bạn đã hoàn thành bài học, bấm vào nút bên dưới để đến với bài học tiếp theo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PronunciationLesson(),
                  ),
                );
              },
              child: Text(
                'Trở lại',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFFDA2C),
                  shape: StadiumBorder(),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width + 100,
                    50,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
