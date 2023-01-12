import '../models/pronounciation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PronounciationService {
  static String name = 'pronouces_lesson';
  static final db = FirebaseFirestore.instance;

  static Future Create(PronuciationLessonModel temp) async {
    await db.collection(name).add(temp.toJson());
  }

  static Future<List<PronuciationLessonModel>> Read(String? id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(name).get();
    return snapshot.docs
        .map((docSnapshot) =>
            PronuciationLessonModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  static Future<void> Update(PronuciationLessonModel item) async {
    await db.collection(name).doc(item.id).update(item.toJson());
  }

  static Future<void> Delete(String documentId) async {
    await db.collection(name).doc(documentId).delete();
  }
}
