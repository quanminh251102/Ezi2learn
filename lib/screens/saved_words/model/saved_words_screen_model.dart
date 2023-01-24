import 'package:cloud_firestore/cloud_firestore.dart';

class SavedWordsModel {
  String? id;
  String userid;
  List<String> words;
  List<String> meanings;

  SavedWordsModel(
      {this.id,
      required this.userid,
      required this.words,
      required this.meanings});

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'words': words,
        'meanings': meanings,
      };

  SavedWordsModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userid = doc.data()!["userid"],
        words = doc.data()?["words"] == null
            ? null
            : doc.data()?["words"].cast<String>(),
        meanings = doc.data()?["meanings"] == null
            ? null
            : doc.data()?["meanings"].cast<String>();
}
