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
    User user = await FirebaseAuth.instance.currentUser!;
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

    if (allList.length == 0) {
      AchievementModel achievementModel = new AchievementModel(
        userId: user.uid!,
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

    print(allList[0].toJson());
    return allList;
  }

  static Future<void> Update(AchievementModel item) async {
    await db.collection(name).doc(item.id).update(item.toJson());
  }

  static Future<void> Delete(String documentId) async {
    await db.collection(name).doc(documentId).delete();
  }
}
