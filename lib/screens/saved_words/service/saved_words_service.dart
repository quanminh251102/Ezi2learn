import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/saved_words_screen_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedWordsService {
  static String name = 'saved_words';
  static final db = FirebaseFirestore.instance;

  static Future Create(SavedWordsModel temp) async {
    await db.collection(name).add(temp.toJson());
  }

  static Future<List<SavedWordsModel>> Read() async {
    User user = FirebaseAuth.instance.currentUser!;
    String id = user.uid;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(name).get();

    var allList = snapshot.docs
        .map((docSnapshot) => SavedWordsModel.fromDocumentSnapshot(docSnapshot))
        .toList();
    print('kiet');
    allList = allList.where((element) {
      return (element.userid == id);
    }).toList();

    if (allList.isEmpty) {
      SavedWordsModel achievementModel = SavedWordsModel(
        userid: user.uid,
        words: [],
        meanings: [],
      );
      await SavedWordsService.Create(achievementModel);

      snapshot = await db.collection(name).get();

      allList = snapshot.docs
          .map((docSnapshot) =>
              SavedWordsModel.fromDocumentSnapshot(docSnapshot))
          .toList();

      allList = allList.where((element) {
        return (element.userid == id);
      }).toList();
    }

    print(allList[0].toJson());
    return allList;
  }

  static Future<void> Update(SavedWordsModel item) async {
    await db.collection(name).doc(item.id).update(item.toJson());
  }

  static Future<void> Delete(String documentId) async {
    await db.collection(name).doc(documentId).delete();
  }
}
