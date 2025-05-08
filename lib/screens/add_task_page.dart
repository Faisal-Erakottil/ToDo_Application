import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task_moel.dart';
import 'package:flutter_application_2/services/task_service.dart'
    show TaskService;
import 'package:uuid/uuid.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  final _taskKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theamdata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _taskKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Add Task",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 5),
                Divider(color: Colors.teal, thickness: 2, endIndent: 50),
                const SizedBox(height: 20),
                TextFormField(
                  style: theamdata.textTheme.displayMedium,
                  controller: _titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title is Required";
                    }
                    return null;
                  },
                  cursorColor: Colors.tealAccent,
                  decoration: InputDecoration(
                    hintText: "Enter Task Title",
                    hintStyle: theamdata.textTheme.displayMedium,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: theamdata.textTheme.displayMedium,
                  controller: _descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description is Required";
                    }
                    return null;
                  },
                  cursorColor: Colors.tealAccent,
                  decoration: InputDecoration(
                    hintText: "Enter Task Description",
                    hintStyle: theamdata.textTheme.displayMedium,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_taskKey.currentState!.validate()) {
                        _addTask();
                      }
                    },
                    child: Container(
                      width: 230,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add Task",
                          style: theamdata.textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addTask() async {
    var id = Uuid().v1();

    TaskModel _taskmodel = TaskModel(
      title: _titleController.text,
      body: _descriptionController.text,
      id: id,
      status: 1,
      createdAt: DateTime.now(),
    );

    TaskService _taskService = TaskService();
    final task = await _taskService.createTask(_taskmodel);

    if (task != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Task Created")));
    }
  }
}
