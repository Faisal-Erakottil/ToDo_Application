// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/services/auth_service.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  UserModel _userModel = UserModel();
  final AuthService _authService = AuthService();

  final _regKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    _userModel = UserModel(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      status: 1,
      createdAt: DateTime.now(),
    );

    try {
      await Future.delayed(Duration(seconds: 2));
      final userdata = await _authService.registerUser(_userModel);

      if (userdata != null) {
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
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theamdata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.white)),
      // ignore: sized_box_for_whitespace
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Form(
                key: _regKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Create an Account",
                        style: theamdata.textTheme.displayLarge,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: theamdata.textTheme.displayMedium,
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
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        style: theamdata.textTheme.displayMedium,
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
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        style: theamdata.textTheme.displayMedium,
                        controller: _nameController,
                        //obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Name ";
                          }
                          return null;
                        },
                        cursorColor: Colors.tealAccent,
                        decoration: InputDecoration(
                          hintText: "Enter Name",
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
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          if (_regKey.currentState!.validate()) {
                            _register();
                            // _userModel = UserModel(
                            //   email: _emailController.text,
                            //   password: _passwordController.text,
                            //   name: _nameController.text,
                            //   status: 1,
                            //   createdAt: DateTime.now(),
                            // );
                            // final userdata= await _authService.registerUser(_userModel);
                            // if (userdata != null) {
                            //   Navigator.pushNamedAndRemoveUntil(
                            //     context,
                            //     '/home',
                            //     (route) => false,
                            //   );
                            // }
                            ////////////////////////////////////
                            // UserCredential UserData = await FirebaseAuth.instance
                            //     .createUserWithEmailAndPassword(
                            //       email: _emailController.text.trim(),
                            //       password: _passwordController.text.trim(),
                            //     );
                  
                            // if (UserData != null) {
                            //   FirebaseFirestore.instance
                            //       .collection('users')
                            //       .doc(UserData.user!.uid)
                            //       .set({
                            //         'uid': UserData.user!.uid,
                            //         'email': UserData.user!.email,
                            //         'name': _nameController.text,
                            //         'createdAt': DateTime.now(),
                            //         'status': 1,
                            //       })
                            //       .then((value) => Navigator.pushNamedAndRemoveUntil(context,'/home', (route)=>false));
                  
                            // }
                            // if (UserData != null) {
                            //   FirebaseFirestore.instance
                            //       .collection("users")
                            //       .doc(UserData.user!.uid)
                            //       .set({
                            //         "uid": UserData.user!.uid,
                            //         "email": UserData.user!.email,
                            //         "name": _nameController.text,
                            //         'createdAt': DateTime.now(),
                            //         'status': 1,
                            //       })
                            //       .then(
                            //         (value) => Navigator.pushNamedAndRemoveUntil(
                            //           context,
                            //           "/home",
                            //           (route) => false,
                            //         ),
                            //       );
                            // }
                            // _userModel = UserModel(
                            //   email: _emailController.text,
                            //   password: _passwordController.text,
                            //   name: _nameController.text,
                            //   status: 1,
                            //   createdAt: DateTime.now(),
                            // );
                  
                            // final userdata = await _authService.registerUser(
                            //   _userModel,
                            // );
                  
                            // if (userdata != null) {
                            //   Navigator.pushNamedAndRemoveUntil(
                            //     context,
                            //     '/home',
                            //     (route) => false,
                            //   );
                            // }
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
                              "Create Account",
                              style: theamdata.textTheme.displayMedium,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: theamdata.textTheme.displayMedium,
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login",
                              style: theamdata.textTheme.displayLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
