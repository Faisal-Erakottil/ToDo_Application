import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task_moel.dart';
import 'package:flutter_application_2/services/task_service.dart'
    show TaskService;
import 'package:uuid/uuid.dart';

class AddTaskView extends StatefulWidget {
  final TaskModel? task;

  const AddTaskView({super.key, this.task});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TaskService _taskService = TaskService();
  bool _edit = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  loadData() {
    if (widget.task != null) {
      setState(() {
        _titleController.text = widget.task!.title!;
        _titleController.text = widget.task!.body!;
        _edit = true;
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
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
                _edit == true
                    ? Text(
                      "Update Task",
                      style: theamdata.textTheme.displayLarge,
                    )
                    : Text(
                      "Add New Task",
                      style: theamdata.textTheme.displayLarge,
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
                /////////////////////////////////////////////////////
                TextFormField(
                  style: theamdata.textTheme.displayMedium,
                  controller: _dateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "select Date";
                    }
                    return null;
                  },
                  cursorColor: Colors.tealAccent,
                  decoration: InputDecoration(
                    hintText: "Select Date",

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
                /////////////////////////
                SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_taskKey.currentState!.validate()) {
                        if (_edit) {
                          TaskModel _taskmodel = TaskModel(
                            id: widget.task!.id,
                            title: _titleController.text,
                            body: _descriptionController.text,
                            status: 1,
                            createdAt: DateTime.now(),
                          );
                          _taskService
                              .updateTask(_taskmodel)
                              .then((value) => Navigator.pop(context));
                        } else {
                          _addTask();
                        }
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
                        child:
                            _edit == true
                                ? Text(
                                  "update Task",
                                  style: theamdata.textTheme.displayMedium,
                                )
                                : Text(
                                  "Add New Task",
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

    TaskModel _taskModel = TaskModel(
      title: _titleController.text,
      body: _descriptionController.text,
      id: id,
      status: 1,
      createdAt: DateTime.now(),
    );

    TaskService _taskService = TaskService();
    final task = await _taskService.createTask(_taskModel);

    if (task != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Task Created")));
    }
  }
}
