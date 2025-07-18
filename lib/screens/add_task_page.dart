import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task_moel.dart';
import 'package:flutter_application_2/services/task_service.dart';
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
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final TaskService _taskService = TaskService();
  bool _edit = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  loadData() {
    if (widget.task != null) {
      setState(() {
        _titleController.text = widget.task!.title!;
        _titleController.text = widget.task!.body!;
        _edit = true;

        if (widget.task!.dueDate != null) {
          _selectedDate = widget.task!.dueDate;
          _dateController.text =
              "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
          _selectedTime = TimeOfDay.fromDateTime(widget.task!.dueDate!);
          _timeController.text = _selectedTime!.format(context);
        }
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  //////////////////////////////////////////////////////////
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
            child: SingleChildScrollView(
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
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () => _selectDate(context),
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
                      prefixIcon: Icon(Icons.calendar_today,color:Colors.white),
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
                  SizedBox(height: 10),
                  TextFormField(
                    style: theamdata.textTheme.displayMedium,
                    controller: _timeController,
                    readOnly: true,
                    //keyboardType: TextInputType.datetime,
                    onTap: () => _selectTime(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Time is Required";
                      }
                      return null;
                    },
                    cursorColor: Colors.tealAccent,
                    decoration: InputDecoration(
                      hintText: "Select Time",
                      prefixIcon: Icon(Icons.access_time,color:Colors.white),
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
                  ////////////////////////
                  SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: _saveTask,
                      child: Container(
                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            _edit ? "Update Task" : "Add New Task",
                            style: theamdata.textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ),
                  )
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       if (_taskKey.currentState!.validate()) {
                  //         if (_edit) {
                  //           TaskModel _taskmodel = TaskModel(
                  //             id: widget.task!.id,
                  //             title: _titleController.text,
                  //             body: _descriptionController.text,
                  //             status: 1,
                  //             createdAt: DateTime.now(),
                  //           );
                  //           _taskService
                  //               .updateTask(_taskmodel)
                  //               .then((value) => Navigator.pop(context));
                  //         } else {
                  //           _addTask();
                  //           Navigator.pop(context);
                  //         }
                  //       }
                  //     },
                  //     child: Container(
                  //       width: 230,
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //         color: Colors.teal,
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: Center(
                  //         child:
                  //             _edit == true
                  //                 ? Text(
                  //                   "update Task",
                  //                   style: theamdata.textTheme.displayMedium,
                  //                 )
                  //                 : Text(
                  //                   "Add New Task",
                  //                   style: theamdata.textTheme.displayMedium,
                  //                 ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  ////////////////////////////////////////////////////////
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////
  void _saveTask() async {
    if (_taskKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please select both a date and time for the task."),
          ),
        );
        return;
      }
      final DateTime finalDueDate = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      if (_edit) {
        //await _taskService.updateTask(task);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Task Updated Successfully")));
      } else {
        //await _taskService.createTask(task);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Task Created Successfully")));
      }
      Navigator.pop(context);
    }
  }

  // _addTask() async {
  //   var id = Uuid().v1();

  //   TaskModel _taskModel = TaskModel(
  //     title: _titleController.text,
  //     body: _descriptionController.text,
  //     id: id,
  //     status: 1,
  //     createdAt: DateTime.now(),
  //   );

  //   TaskService _taskService = TaskService();
  //   final task = await _taskService.createTask(_taskModel);

  //   if (task != null) {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Task Created")));
  //   }
  // }
  //////////////////////////////////////////////////

  ////////////////////////////////
  //time picker function
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  /////////////////////////////////////////////////////////////////
  //date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
