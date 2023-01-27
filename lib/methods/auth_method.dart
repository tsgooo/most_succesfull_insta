import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tagramm/methods/storage_method.dart';
import 'package:tagramm/models/user.dart' as model;

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          username.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          confirmPassword == password) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethod()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          email: email,
          username: username,
          uid: cred.user!.uid,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = 'Success';
      } else if (email.isNotEmpty &&
          username.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          confirmPassword != password) {
        res = 'You blind fuck, the passwords aren\'t same';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'Success';
      } else {
        res = 'Please fill the all fields, u blin fk';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
