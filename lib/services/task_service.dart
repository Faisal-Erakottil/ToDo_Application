import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/models/task_moel.dart' show TaskModel;

class TaskService {
  final CollectionReference _taskCollection = FirebaseFirestore.instance
      .collection('tasks');

  //create task

  Future<TaskModel?> createTask(TaskModel task) async {
    try {
      final taskMap = TaskModel().toMap();
      await _taskCollection.doc(task.id).set(taskMap);
      return task;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  // get all tasks

  //update task

  //delete task
}
