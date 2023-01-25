import 'package:flutter/material.dart';
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
            const SizedBox(
              height: 100,
            ),
            const Image(
              image: NetworkImage(
                  'https://thumbs.gfycat.com/FarawayTestyChimneyswift-max-1mb.gif'),
            ),
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PronunciationLesson(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFFDA2C),
                  shape: const StadiumBorder(),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width + 100,
                    50,
                  )),
              child: const Text(
                'Trở lại',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
