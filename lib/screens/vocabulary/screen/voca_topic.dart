import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_main.dart';
import '../widget/topic_card.dart';

class VocaTopicScreen extends StatefulWidget {
  const VocaTopicScreen({super.key});

  @override
  State<VocaTopicScreen> createState() => _VocaTopicScreenState();
}

class _VocaTopicScreenState extends State<VocaTopicScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
                                          point: int.parse('${doc['point']}')))
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
                                        );
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
