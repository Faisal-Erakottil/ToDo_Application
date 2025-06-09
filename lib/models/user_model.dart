import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  String? password;
  DateTime? createdAt;
  int? status;
  String? uid;
  String? fcmToken;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.createdAt,
    this.status,
    this.uid,
    this.fcmToken
  });

  factory UserModel.fromjson(DocumentSnapshot data) {
    return UserModel(
      email: data['email'],
      uid: data['uid'],
      name: data['name'],
      status: data['status'],
      fcmToken: data['fcmToken'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password': password,
      'status': status,
      'createdAt': createdAt,
      'fcmToken': fcmToken,
    };
  }
  
}
