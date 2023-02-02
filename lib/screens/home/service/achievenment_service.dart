import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/achievement_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AchievenmentService {
  static String name = 'achievement';
  static final db = FirebaseFirestore.instance;

  static Future Create(AchievementModel temp) async {
    await db.collection(name).add(temp.toJson());
  }

  static Future<List<AchievementModel>> Read() async {
    User user = FirebaseAuth.instance.currentUser!;
    String id = user.uid;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(name).get();

    var allList = snapshot.docs
        .map(
            (docSnapshot) => AchievementModel.fromDocumentSnapshot(docSnapshot))
        .toList();
    print('kiet');
    allList = allList.where((element) {
      return (element.userId == id);
    }).toList();

    if (allList.isEmpty) {
      AchievementModel achievementModel = AchievementModel(
        userId: user.uid,
        toltalSpeakingPoint: 0,
        toltalVocabularyPoint: 0,
      );
      await AchievenmentService.Create(achievementModel);

      snapshot = await db.collection(name).get();

      allList = snapshot.docs
          .map((docSnapshot) =>
              AchievementModel.fromDocumentSnapshot(docSnapshot))
          .toList();

      allList = allList.where((element) {
        return (element.userId == id);
      }).toList();
    }

    if (allList.length > 1) {
      for (int i = 1; i < allList.length; i++) await Delete(allList[i].id);
    }

    print(allList[0].toJson());
    return allList;
  }

  static Future<List<AchievementModel>> ReadWithUserId(String id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(name).get();

    var allList = snapshot.docs
        .map(
            (docSnapshot) => AchievementModel.fromDocumentSnapshot(docSnapshot))
        .toList();
    print('kiet');
    allList = allList.where((element) {
      return (element.userId == id);
    }).toList();

    print(allList[0].toJson());
    return allList;
  }

  static Future<void> Update(String type) async {
    List<AchievementModel> list = await Read();

    AchievementModel item = list[0];

    if (type == "Pronunciation") {
      item.toltalSpeakingPoint++;
    }

    if (type == "Vocabulary") {
      item.toltalVocabularyPoint = item.toltalVocabularyPoint + 10;
    }

    await db.collection(name).doc(item.id).update(item.toJson());
  }

  static Future<void> Delete(String? documentId) async {
    await db.collection(name).doc(documentId).delete();
  }

  static Future<void> updatescrorewhenExit(
      String type, int currentScore) async {
    List<AchievementModel> list = await Read();

    AchievementModel item = list[0];

    if (type == "Pronunciation") {
      item.toltalSpeakingPoint;
    }

    if (type == "Vocabulary") {
      item.toltalVocabularyPoint = item.toltalVocabularyPoint - currentScore;
    }

    await db.collection(name).doc(item.id).update(item.toJson());
  }
}
