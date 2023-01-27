import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rive_animation/screens/vocabulary/model/option.dart';
import 'package:rive_animation/screens/vocabulary/model/question.dart';
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
        point: tempTopic.point,
        done: tempTopic.done);
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
    await docVoca
        .doc(id)
        .collection('vocabularies')
        .doc(tempVoca.text)
        .set(json);
  }

  static Future addQuestion({required Question tempQuestion}) async {
    final db = FirebaseFirestore.instance;
    final docQuestion = db.collection('questions').doc(tempQuestion.text);
    final question = Question(
      id: docQuestion.id,
      topic: tempQuestion.topic,
      text: tempQuestion.text,
      image: tempQuestion.image,
      isLocked: tempQuestion.isLocked,
      selectedOption: tempQuestion.selectedOption,
      options: tempQuestion.options
    );
    final json = question.toJson();
    await docQuestion
        .set(json)
        .onError((e, _) => print("Error writing document: $e"));
    // await addvocabinTopic(id: docTopic.id, listVoca: tempVoca);
  }

  static Future addoptioninQuestion(
      {required String id, required Option tempOption}) async {
    final db = FirebaseFirestore.instance;
    final docOption = db.collection('questions');
    final option = Option(
      ruid: id,
      text: tempOption.text,
      isCorrect: tempOption.isCorrect,
    );
    final json = option.toJson();
    await docOption
        .doc(id)
        .collection('options')
        .doc(tempOption.text)
        .set(json);
  }
}
