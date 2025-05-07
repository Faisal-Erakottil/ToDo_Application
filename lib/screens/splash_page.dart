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
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = _pref.getString('token');
    name =  _pref.getString('name');
    uid =  _pref.getString('uid');
    email = _pref.getString('email');

  }


    @override
    void initState() {

      getData();

      var d=Duration(seconds: 2);

      Future.delayed(d, () {   
        checkLoginStatus();
      });

      super.initState();

    }

    Future<void> checkLoginStatus() async {
      if (token == null) {
        Navigator.pushNamed(context, "/");
      }else{
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
