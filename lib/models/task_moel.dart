import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String? title;
  String? body;
  int? status;
  DateTime? createdAt;
  DateTime? dueDate;

  TaskModel({this.id, this.title, this.body, this.status, this.createdAt,this.dueDate});

  factory TaskModel.fromJson(DocumentSnapshot json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      status: json['status'],
      dueDate: (json['dueDate'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'status': status,
      'createdAt': createdAt,
      'dueDate': dueDate,
    };
  }
}
