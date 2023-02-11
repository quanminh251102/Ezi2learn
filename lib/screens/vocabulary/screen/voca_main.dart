import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_quiz.dart';
import 'package:rive_animation/screens/vocabulary/screen/voca_topic.dart';
import 'package:rive_animation/screens/vocabulary/widget/flashcard.dart';
import 'package:rive_animation/screens/vocabulary/widget/voca_card.dart';

class VocaMainScreen extends StatefulWidget {
  const VocaMainScreen({super.key, required this.topic});
  final Topic topic;
  @override
  State<VocaMainScreen> createState() => _VocaMainScreenState();
}

class _VocaMainScreenState extends State<VocaMainScreen> {
  //Update Score
  //Text To Speech
  FlutterTts flutterTts = FlutterTts();
  //
  List<Vocabulary> fullList = [];
  int studiedCount = 0;
  int listCount = 0;
  int currentIndex = 0;
  bool isvisibleSwiper = false;
  bool isFinish = false;
  bool test = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = SwiperController();
    final db = FirebaseFirestore.instance;
    Future<QuerySnapshot> getVocabularies() async {
      QuerySnapshot querySnapshot = await db
          .collection('topics')
          .doc(widget.topic.title)
          .collection('vocabularies')
          .get();
      return querySnapshot;
    }

    Future<int> getstudiedVocabularies() async {
      QuerySnapshot vocabulariesRef = await FirebaseFirestore.instance
          .collection('topics')
          .doc(widget.topic.title)
          .collection('vocabularies')
          .where('studied', isEqualTo: true)
          .get();
      return vocabulariesRef.docs.length;
    }

// ...
    Future<QuerySnapshot> vocabularies = getVocabularies();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.topic.title,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VocaTopicScreen()),
            ).then((_) => setState(() {}));
          },
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
            child: FutureBuilder<QuerySnapshot>(
                future: vocabularies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    listCount = documents.length;
                    return SizedBox(
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
                            List<Vocabulary> vocabularies = documents
                                .map((doc) => Vocabulary(
                                    id: '${doc['id']}',
                                    meaning: '${doc['meaning']}',
                                    image: '${doc['image']}',
                                    spelling: '${doc['spelling']}',
                                    text: '${doc['text']}',
                                    studied: '${doc['studied']}' == 'true'
                                        ? true
                                        : false))
                                .toList();
                            return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    controller.index = index;
                                  });
                                  await db
                                      .collection('topics')
                                      .doc(widget.topic.title)
                                      .update({
                                    'progress': 2,
                                  });
                                  await db
                                      .collection('topics')
                                      .doc(widget.topic.title)
                                      .collection('vocabularies')
                                      .doc(vocabularies[index].text)
                                      .update({
                                    'studied': true,
                                  });
                                  await showGeneralDialog(
                                    barrierLabel: "Label",
                                    barrierDismissible: true,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    transitionDuration:
                                        const Duration(milliseconds: 700),
                                    context: context,
                                    pageBuilder: (context, anim1, anim2) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: Swiper(
                                            loop: false,
                                            pagination:
                                                const SwiperPagination(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10)),
                                            viewportFraction: 0.6,
                                            scale: 0.8,
                                            controller: controller,
                                            itemCount: documents.length,
                                            onIndexChanged:
                                                (int index) async {
                                              await db
                                                  .collection('topics')
                                                  .doc(widget.topic.title)
                                                  .collection('vocabularies')
                                                  .doc(vocabularies[index]
                                                      .text)
                                                  .update({
                                                'studied': true,
                                              });
                                            },
                                            itemBuilder: (context, index) {
                                              return FlashCard(
                                                  vocabulary:
                                                      vocabularies[index]);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                      return SlideTransition(
                                        position: Tween(
                                                begin: const Offset(0, 1),
                                                end: const Offset(0, 0))
                                            .animate(anim1),
                                        child: child,
                                      );
                                    },
                                  ).then((_) => setState(() {}));
                                },
                                child: VocaCard(
                                  vocabulary: vocabularies[index],
                                  isChecked: vocabularies[index].studied,
                                ));
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('$snapshot.error');
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await getstudiedVocabularies().then((value) => studiedCount = value);
          if (studiedCount < listCount) {
            showDialog(
              context: context,
              builder: (_) => AssetGiffDialog(
                image: Image.asset(
                  'assets/gif/not_done.gif',
                  fit: BoxFit.contain,
                ),
                title: const Text(
                  'Oops!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                entryAnimation: EntryAnimation.bottomRight,
                description: const Text(
                  'Có vẻ bạn chưa hoàn thành các từ vựng mới, bạn có chắc muốn tham gia bài kiểm tra chứ ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                buttonOkText: const Text(
                  'Tiếp tục',
                  style: TextStyle(color: Colors.white),
                ),
                buttonCancelText: const Text(
                  'Quay lại',
                  style: TextStyle(color: Colors.white),
                ),
                onOkButtonPressed: () async {
                  await db.collection('topics').doc(widget.topic.title).update({
                    'progress': 2,
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VocaQuiz(topic: widget.topic)),
                  ).then((_) => Navigator.of(context).pop());
                },
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (_) => AssetGiffDialog(
                image: Image.asset(
                  'assets/gif/done.gif',
                  fit: BoxFit.cover,
                  width: 10,
                  height: 10,
                ),
                title: const Text(
                  'Chúc mừng !',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                entryAnimation: EntryAnimation.bottomRight,
                description: const Text(
                  'Chà có vẻ bạn đã hoàn thành học các từ vựng mới, cùng kiểm tra lại kiến thức của mình nhé !',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                buttonOkText: const Text(
                  'Tiếp tục',
                  style: TextStyle(color: Colors.white),
                ),
                buttonCancelText: const Text(
                  'Quay lại',
                  style: TextStyle(color: Colors.white),
                ),
                onOkButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VocaQuiz(topic: widget.topic)),
                  ).then((_) => Navigator.of(context).pop());
                },
              ),
            );
          }
        },
        backgroundColor: const Color(0xff49B0AB),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Kiểm tra từ vựng',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
