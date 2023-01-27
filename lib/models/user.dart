import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String uid;
  final String photoUrl;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.username,
    required this.followers,
    required this.following,
    required this.photoUrl,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        'email': email,
        'photoUrl': photoUrl,
        'following': following,
        'followers': followers
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      username: snapshot['username'],
      followers: snapshot['followers'],
      following: snapshot["following"],
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
    );
  }
}
