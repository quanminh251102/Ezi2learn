import 'package:flutter/material.dart';
import 'package:rive_animation/screens/auth/service/auth_service.dart';
import 'package:rive_animation/screens/pronunciation/screen/pronunciation_lesson.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 20),
                child: Text(
                  "Courses",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Thử thách hôm nay',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VocaTopicScreen(),
                              ),
                            );
                          },
                          child: Courses(
                              'assets/images/voca.jpg', 'Vocabulary', context),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PronunciationLesson(),
                              ),
                            );
                          },
                          child: Courses('assets/images/speaking.png',
                              'Speaking', context),
                        ),
                        Courses('assets/images/dictionary.jpg', 'Listening',
                            context),
                        Courses(
                            'assets/images/dictionary.jpg', 'Gaming', context),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(right: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/grammar.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        stops: const [
                          0.1,
                          0.9
                        ],
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.1)
                        ]),
                  ),
                  child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Grammar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  AuthService.LogOut();
                },
                child: Text('Đăng xuất')),
          ],
        ),
      ),
    );
  }
}

Widget Courses(image, topic, context) {
  return AspectRatio(
    aspectRatio: 2.95 / 3,
    child: Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(begin: Alignment.bottomRight, stops: const [
            0.1,
            0.9
          ], colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.1)
          ]),
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              topic,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
      ),
    ),
  );
}
