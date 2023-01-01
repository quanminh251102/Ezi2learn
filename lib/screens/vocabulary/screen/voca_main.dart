import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';
import 'package:rive_animation/screens/vocabulary/widget/flashcard.dart';
import 'package:rive_animation/screens/vocabulary/widget/voca_card.dart';

class VocaMainScreen extends StatefulWidget {
  const VocaMainScreen({super.key, required this.topic});
  final Topic topic;
  @override
  State<VocaMainScreen> createState() => _VocaMainScreenState();
}

class _VocaMainScreenState extends State<VocaMainScreen> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    Future<QuerySnapshot> vocabularies = db
        .collection('topics')
        .doc(widget.topic.title)
        .collection('vocabularies')
        .get();
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
              child: FutureBuilder<QuerySnapshot>(
                  future: vocabularies,
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
                              List<Vocabulary> vocabularies = documents
                                  .map((doc) => Vocabulary(
                                      id: '${doc['id']}',
                                      meaning: '${doc['meaning']}',
                                      image: '${doc['image']}',
                                      spelling: '${doc['spelling']}',
                                      text: '${doc['text']}'))
                                  .toList();
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FlashCard(
                                                    vocabulary: vocabularies[index],
                                                  )),
                                        );
                                },
                                child: VocaCard(vocabulary: vocabularies[index]));
                            },
                          ),
                        ),
                      ));
                    } else if (snapshot.hasError) {
                      return Text('$snapshot.error');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
