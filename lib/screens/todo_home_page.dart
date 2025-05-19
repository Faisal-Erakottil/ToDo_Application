import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task_moel.dart';
import 'package:flutter_application_2/screens/add_task_page.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:flutter_application_2/services/task_service.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  @override
  Widget build(BuildContext context) {
    final theamdate = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushNamed(context, "/addtask");
        },
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text("Hi", style: theamdate.textTheme.displayLarge),
                      SizedBox(width: 10),
                      Text("Faisal", style: theamdate.textTheme.displayLarge),
                    ],
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      //final user = FirebaseAuth.instance.currentUser;
                      AuthService().logoutUser().then((value) {
                        //print(user!.email);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/",
                          (route) => false,
                        );
                      });
                      // print(user!.uid);
                    },
                    icon: Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text("Your Tasks", style: theamdate.textTheme.displayMedium),
            SizedBox(height: 15),

            StreamBuilder<List<TaskModel>>(
              stream: TaskService().getAllTasks(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data!.length == 0) {
                  return Center(
                    child: Text(
                      "No Tasks Found",
                      style: theamdate.textTheme.displaySmall,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      //"Somthing went Wrong",
                      snapshot.error.toString(),
                      style: theamdate.textTheme.displaySmall,
                    ),
                  );
                }

                if (snapshot.hasData && snapshot.data!.length != 0) {
                  List<TaskModel> tasks = snapshot.data ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final _task = tasks[index];
                      print(_task);

                      return Card(
                        elevation: 5,
                        color: theamdate.scaffoldBackgroundColor,

                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.circle_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            "${_task.title}",
                            style: theamdate.textTheme.displaySmall,
                          ),
                          subtitle: Text(
                            "${_task.body}",
                            style: theamdate.textTheme.displaySmall,
                          ),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddTaskView(task:_task),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, color: Colors.teal),
                                ),
                                IconButton(
                                  onPressed: () {
                                    
                                    TaskService().deleteTask(_task.id!);
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Text(
                    "some error occured",
                    style: theamdate.textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
