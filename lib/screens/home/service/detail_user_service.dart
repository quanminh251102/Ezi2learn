import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/detail_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailUserService {
  static String name = 'detail_user';
  static final db = FirebaseFirestore.instance;

  static Future Create(DetailUserModel temp) async {
    await db.collection(name).add(temp.toJson());
  }

  static Future<List<DetailUserModel>> ReadAll() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(name).get();

    var allList = snapshot.docs
        .map((docSnapshot) => DetailUserModel.fromDocumentSnapshot(docSnapshot))
        .toList();

    return allList;
  }

  static Future<List<DetailUserModel>> Read() async {
    User? user = FirebaseAuth.instance.currentUser;
    String id = user!.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(name).get();

    var allList = snapshot.docs
        .map((docSnapshot) => DetailUserModel.fromDocumentSnapshot(docSnapshot))
        .toList();

    allList = allList.where((element) {
      return (element.userId == id);
    }).toList();

    if (allList.isEmpty) {
      DetailUserModel detailUserModel = DetailUserModel(
        userId: user.uid,
        birthDay: DateTime.now(),
        address: '',
        gender: '',
        avatarUrl: '',
        phoneNumber: '',
        gmail: user.email as String,
      );

      await DetailUserService.Create(detailUserModel);

      snapshot = await db.collection(name).get();

      allList = snapshot.docs
          .map((docSnapshot) =>
              DetailUserModel.fromDocumentSnapshot(docSnapshot))
          .toList();

      allList = allList.where((element) {
        return (element.userId == id);
      }).toList();
    }

    if (allList.length == 2) {
      await Delete(allList[1].id);
    }
    print(allList[0].toJson());
    return allList;
  }

  static Future<void> Update(DetailUserModel? item) async {
    await db.collection(name).doc(item?.id).update(item!.toJson());
  }

  static Future<void> Delete(String? documentId) async {
    await db.collection(name).doc(documentId).delete();
  }
}
