import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  Future<void> signIn(String email, String password) async {
    final credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(credentials.user!.uid)
        .get()
        .then((value) {
      _user = UserModel.fromJson(value);
    });
    notifyListeners();
  }

  Future<void> signUp(UserModel userModel) async {
    final credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userModel.email!, password: userModel.password!);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(credentials.user!.uid)
        .set(userModel.toJson());
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> getUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final results =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    _user = UserModel.fromJson(results);
  }
}
