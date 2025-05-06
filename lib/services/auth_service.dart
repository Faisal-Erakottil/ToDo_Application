import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection('users');
  Future<UserCredential?> registerUser(UserModel user) async {
    UserCredential userdata = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: user.email.toString(),
          password: user.password.toString(),
        );
    if (userdata != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userdata.user!.uid)
          .set({
            "uid": userdata.user!.uid,
            'email': userdata.user!.email,
            'name': user.name,
            'createdAt': user.createdAt,
            'status': user.status,
          });
          return userdata;
    }
  }
  // add

  // login

  // save the data to shared preferences
}
