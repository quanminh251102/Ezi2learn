
import 'package:cloud_firestore/cloud_firestore.dart';

class PronuciationLessonModel {
  String? id;
  String title;
  String subTilte;
  List<String> words;
  List<String> meanings;

  PronuciationLessonModel(
      {this.id,
      required this.title,
      required this.subTilte,
      required this.words,
      required this.meanings});

  Map<String, dynamic> toJson() => {
        'title': title,
        'subTilte': subTilte,
        'words': words,
        'meanings': meanings,
      };

  PronuciationLessonModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!["title"],
        subTilte = doc.data()!["subTilte"],
        words = doc.data()?["words"] == null
            ? null
            : doc.data()?["words"].cast<String>(),
        meanings = doc.data()?["meanings"] == null
            ? null
            : doc.data()?["meanings"].cast<String>();
}
