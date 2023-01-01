import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';

class ApiServices {
  static Future addTopic({required Topic tempTopic}) async {
    final db = FirebaseFirestore.instance;
    final docTopic = db.collection('topics').doc(tempTopic.title);
    final topic = Topic(
        id: docTopic.id,
        title: tempTopic.title,
        image: tempTopic.image,
        progress: tempTopic.progress,
        point: tempTopic.point);
    final json = topic.toJson();
    await docTopic
        .set(json)
        .onError((e, _) => print("Error writing document: $e"));
    // await addvocabinTopic(id: docTopic.id, listVoca: tempVoca);
  }

  static Future addvocabinTopic(
      {required String? id, required Vocabulary tempVoca}) async {
    final db = FirebaseFirestore.instance;
    final docVoca = db.collection('topics');
    final voca = Vocabulary(
        text: tempVoca.text,
        image: tempVoca.image,
        spelling: tempVoca.spelling,
        meaning: tempVoca.meaning);
    final json = voca.toJson();
    await docVoca.doc(id).collection('vocabularies').doc(tempVoca.text).set(json);
  }
}
