import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementModel {
  String? id;
  String userId;
  int toltalSpeakingPoint;
  int toltalVocabularyPoint;

  AchievementModel({
    this.id,
    required this.userId,
    required this.toltalSpeakingPoint,
    required this.toltalVocabularyPoint,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'toltalSpeakingPoint': toltalSpeakingPoint,
        'toltalVocabularyPoint': toltalVocabularyPoint
      };

  AchievementModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userId = doc.data()!["userId"],
        toltalSpeakingPoint = doc.data()!["toltalSpeakingPoint"],
        toltalVocabularyPoint = doc.data()!["toltalVocabularyPoint"];
}
