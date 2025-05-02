import 'package:flutter/material.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Add Task", style: Theme.of(context).textTheme.displayLarge),
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
            ],
          ),
        ),
      ),
    );
  }
}
