
import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementProciationLessonModel {
  String? id;
  String achievementId;
  String prouciationId;
  String userId;
  int numCorrectWord;

  AchievementProciationLessonModel(
      {this.id,
      required this.achievementId,
      required this.prouciationId,
      required this.userId,
      required this.numCorrectWord});

  Map<String, dynamic> toJson() => {
        'achievementId': achievementId,
        'prouciationId': prouciationId,
        'userId': userId,
        'numCorrectWord': numCorrectWord.toString(),
      };

  AchievementProciationLessonModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        achievementId = doc.data()!["achievementId"],
        prouciationId = doc.data()!["prouciationId"],
        userId = doc.data()!["userId"],
        numCorrectWord = doc.data()!["numCorrectWord"] as int;
}
