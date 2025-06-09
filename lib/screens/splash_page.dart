import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String? name;
  String? email;
  String? uid;
  String? token;
  //=================taking values from shared preferences
  void initState() {
    super.initState();
    _initFCMandGetData();
  }

  Future<void> _initFCMandGetData() async {
    await _initializeFCM();
    await getData();

    var d = Duration(seconds: 2);
    Future.delayed(d, () {
      checkLoginStatus();
    });
  }

  Future<void> _initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print("User granted permission: ${settings.authorizationStatus}");

    String? fcmToken = await messaging.getToken();
    print("FCM Token: $fcmToken");
    if (fcmToken != null) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.setString('fcmToken', fcmToken);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("got a message whilst in the foreground!");
      print("Message data: ${message.data}");

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${message.notification!.title}: ${message.notification!.body}",
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print("Message data: ${message.data}");

      if (message.data['screen'] == 'home') {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = _pref.getString('token');
    name = _pref.getString('name');
    uid = _pref.getString('uid');
    email = _pref.getString('email');
  }

  @override
  // void initState() {
  //   getData(); 

  //   var d = Duration(seconds: 2);

  //   Future.delayed(d, () {
  //     checkLoginStatus();
  //   });

  //   super.initState();
  // }

  Future<void> checkLoginStatus() async {
    if (token == null) {
      Navigator.pushNamed(context, "/");
    } else {
      Navigator.pushNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "To Do APP",
          style: TextStyle(color: Colors.amber, fontSize: 30),
        ),
      ),
    );
  }
}
