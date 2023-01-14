import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DetailUserModel {
  String? id;
  String userId;
  DateTime birthDay;
  String address;
  String gender;
  String avatarUrl;
  String phoneNumber;

  DetailUserModel({
    this.id,
    required this.userId,
    required this.birthDay,
    required this.address,
    required this.gender,
    required this.avatarUrl,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'birthDay': Timestamp.fromDate(birthDay),
        'address': (address == null) ? '' : address,
        'gender': (gender == null) ? '' : gender,
        'avatarUrl': (avatarUrl == null) ? '' : avatarUrl,
        'phoneNumber': (phoneNumber == null) ? '' : phoneNumber,
      };

  DetailUserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userId = doc.data()!["userId"],
        birthDay = (doc.data()!["birthDay"] as Timestamp).toDate(),
        address = doc.data()?["address"] == null ? '' : doc.data()?["address"],
        gender = doc.data()?["gender"] == null ? '' : doc.data()?["gender"],
        avatarUrl =
            doc.data()?["avatarUrl"] == null ? '' : doc.data()?["avatarUrl"],
        phoneNumber = doc.data()?["phoneNumber"] == null
            ? ''
            : doc.data()?["phoneNumber"];
}
