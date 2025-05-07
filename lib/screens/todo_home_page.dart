import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/auth_service.dart';

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
                      final user = FirebaseAuth.instance.currentUser;
                      AuthService().logoutUser() .then((value) {
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: theamdate.scaffoldBackgroundColor,

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.circle_outlined, color: Colors.white),
                    ),
                    title: Text(
                      "Todo one",
                      style: theamdate.textTheme.displaySmall,
                    ),
                    subtitle: Text(
                      "complete the assignment before 10 am tommorrow",
                      style: theamdate.textTheme.displaySmall,
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit, color: Colors.teal),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
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
