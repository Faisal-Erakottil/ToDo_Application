import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/screens/add_task_page.dart';
import 'package:flutter_application_2/screens/login_page.dart';
import 'package:flutter_application_2/screens/register_page.dart';
import 'package:flutter_application_2/screens/splash_page.dart';
import 'package:flutter_application_2/screens/todo_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

//====================Function for background message handling
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Handle the background message here
  print("Handling a background message: ${message.messageId}");
}

  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do Application',
      initialRoute: "/splash",
      routes: {
        "/": (context) => Loginview(),
        "/register": (context) => Registerview(),
        "/home": (context) => TodoHomePage(),
        "/addtask": (context) => AddTaskView(),
        "/splash": (context) => SplashView(),
      },
      theme: ThemeData(
        textTheme: TextTheme(
          
          displayLarge: TextStyle(color: Colors.white, fontSize: 25),
          displayMedium: TextStyle(color: Colors.white, fontSize: 18),
          displaySmall: TextStyle(color: Colors.white, fontSize: 14),
        ),
        scaffoldBackgroundColor: Color(0xff0E1D3E),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xff0E1D3E)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      
      //home: Loginview(),
    );
  }
}
