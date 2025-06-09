import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection('users');

  // creating new user in fire store
  Future<UserCredential?> registerUser(UserModel user) async {
    UserCredential userData = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: user.email.toString(),
          password: user.password.toString(),
        );
    if (userData.user != null) {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userData.user!.uid)
          .set({
            "uid": userData.user!.uid,
            'email': userData.user!.email,
            'name': user.name,
            'createdAt': user.createdAt,
            'status': user.status,
            'fcmToken': fcmToken,
          });
      return userData;
    }
    return null;
  }

  // login
  Future<DocumentSnapshot?> loginUser(UserModel user) async {
    DocumentSnapshot? snap;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: user.email.toString(),
      password: user.password.toString(),
    );
    // get the token
    String? token = await userCredential.user!.getIdToken();
    if (userCredential.user != null) {
      snap = await _userCollection.doc(userCredential.user!.uid).get();
      // save the data to shared preferences
      await _pref.setString("token", token!);
      await _pref.setString('name', snap['name']);
      await _pref.setString('email', snap['email']);
      await _pref.setString('uid', snap['uid']);

      // get the fcm token
      String? fcmToken =
          await FirebaseMessaging.instance.getToken();
      if(fcmToken != null){
await _pref.setString('fcmToken', fcmToken);
      }
      return snap;
    }
    return null;
  }

  // logout
  Future<void> logoutUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    String? uid = _pref.getString('uid');
    if(uid != null){
      await _userCollection.doc(uid).update({
        'fcmToken': FieldValue.delete(),
      });
    }
    await _pref.clear();
    await _auth.signOut();
  }

  //checking if user is logged in or not
  Future<bool> isloggedin() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? _token = await _pref.getString('token');
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }

  //==== Function to save FCM token
  Future<void> saveFCMTokenToUser(String? uid, String? fcmToken) async {
    if (uid != null && fcmToken != null) {
      await _userCollection.doc(uid).set({'fcmToken': fcmToken}, SetOptions(merge: true));
      print("FCM Token saved for user $uid");
    }
  }
}
