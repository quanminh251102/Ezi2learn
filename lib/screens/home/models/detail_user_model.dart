
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailUserModel {
  String? id;
  String userId;
  DateTime birthDay;
  String address;
  String gender;
  String avatarUrl;
  String phoneNumber;
  String gmail;

  DetailUserModel({
    this.id,
    required this.userId,
    required this.birthDay,
    required this.address,
    required this.gender,
    required this.avatarUrl,
    required this.phoneNumber,
    required this.gmail,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'birthDay': Timestamp.fromDate(birthDay),
        'address': (address == null) ? '' : address,
        'gender': (gender == null) ? '' : gender,
        'avatarUrl': (avatarUrl == null) ? '' : avatarUrl,
        'phoneNumber': (phoneNumber == null) ? '' : phoneNumber,
        'gmail': (gmail == null) ? '' : gmail,
      };

  DetailUserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userId = doc.data()!["userId"],
        birthDay = (doc.data()!["birthDay"] as Timestamp).toDate(),
        address = doc.data()?["address"] ?? '',
        gender = doc.data()?["gender"] ?? '',
        avatarUrl =
            doc.data()?["avatarUrl"] ?? '',
        phoneNumber = doc.data()?["phoneNumber"] ?? '',
        gmail = doc.data()?["gmail"] ?? '';
}
