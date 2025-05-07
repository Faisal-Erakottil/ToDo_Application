import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/services/auth_service.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();
  UserModel _userMaodel = UserModel();
  AuthService _authService = AuthService();

  bool _isLoading = false;
  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _userMaodel = UserModel(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final data = await _authService.loginUser(_userMaodel);

      if (data != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      List err = e.toString().split("]");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(err[1])));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theamdata = Theme.of(context);
    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Form(
                key: _loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login to Your Account",
                      style: theamdata.textTheme.displayLarge,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: theamdata.textTheme.displaySmall,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter an Email ID ";
                        }
                        return null;
                      },
                      cursorColor: Colors.tealAccent,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: theamdata.textTheme.displaySmall,
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
                    SizedBox(height: 10),
                    TextFormField(
                      style: theamdata.textTheme.displaySmall,
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                      cursorColor: Colors.tealAccent,
                      decoration: InputDecoration(
                        hintText: "Enter Password",

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
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        if (_loginKey.currentState!.validate()) {
                          //     UserCredential userdata=await FirebaseAuth.instance.signInWithEmailAndPassword(
                          //   email: _emailController.text.trim(),
                          //   password: _passwordController.text.trim(),
                          // );
                          // if(userdata!=null){
                          //   Navigator.pushNamedAndRemoveUntil(context, "/home", (route)=>false);
                          // }
                          _login();
                        }
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: theamdata.textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Don't have an Account?",
                          style: theamdata.textTheme.displayMedium,
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Create an Account",
                            style: theamdata.textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _login() async {
  //   UserCredential userdata = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //   if (userdata != null) {
  //     Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
  //   }
  // }
}
