import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_main.dart';
import '../../home/models/achievement_model.dart';
import '../../home/service/achievenment_service.dart';
import '../widget/topic_card.dart';

class VocaTopicScreen extends StatefulWidget {
  const VocaTopicScreen({super.key});

  @override
  State<VocaTopicScreen> createState() => _VocaTopicScreenState();
}

class _VocaTopicScreenState extends State<VocaTopicScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  AchievementModel? achievementModel;
  final int pointEachLevel = 100;
  int currentPoint = 0;
  double processValue = 0;
  int point_need_to_up_level = 0;
  int currentLevel = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    AchievenmentService.Read().then((valueAchi) {
      setState(() {
        achievementModel = valueAchi[0];
        currentPoint = achievementModel!.toltalVocabularyPoint % pointEachLevel;
        processValue = (currentPoint.toDouble() / pointEachLevel) * 100;
        currentLevel = achievementModel!.toltalVocabularyPoint ~/ pointEachLevel;
        point_need_to_up_level = pointEachLevel -
            (achievementModel!.toltalVocabularyPoint % pointEachLevel);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Storage storage = Storage();
    final db = FirebaseFirestore.instance;
    Future<QuerySnapshot> vocaTopic = db.collection('topics').get();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Vocabulary',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Center(
                      child: FAProgressBar(
                    backgroundColor: const Color(0xffC4C4C4),
                    changeProgressColor: const Color(0xffFFDA2C),
                    progressColor: const Color(0xffFFDA2C),
                    currentValue: processValue,
                    displayText: '%',
                    size: 20,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Level $currentLevel',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${processValue.toStringAsFixed(2)}% - More $point_need_to_up_level pts to reach Level ${currentLevel + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xff8A8A8A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<QuerySnapshot>(
                      future: vocaTopic,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          return Expanded(
                              child: SizedBox(
                            child: SingleChildScrollView(
                              child: GridView.builder(
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: documents.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 1.1,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  List<Topic> topics = documents
                                      .map((doc) => Topic(
                                          title: '${doc['title']}',
                                          image: '${doc['image']}',
                                          progress:
                                              int.parse('${doc['progress']}'),
                                          point: int.parse('${doc['point']}'),
                                          done: '${doc['done']}' == 'true'
                                              ? true
                                              : false))
                                      .toList();
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VocaMainScreen(
                                                    topic: topics[index],
                                                  )),
                                        ).then((_) => setState(() {}));
                                      },
                                      child:
                                          TopicCard(vocaTopic: topics[index]));
                                },
                              ),
                            ),
                          ));
                        } else if (snapshot.hasError) {
                          return Text('$snapshot.error');
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
