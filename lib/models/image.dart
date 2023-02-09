import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.username,
    required this.postId,
    required this.description,
    required this.postUrl,
    required this.uid,
    required this.datePublished,
    required this.likes,
    required this.profileImage,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        'postId': postId,
        'postUrl': postUrl,
        'description': description,
        'datePublished': datePublished,
        'profileImage': profileImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      description: snapshot['description'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot["postUrl"],
      postId: snapshot['postId'],
      uid: snapshot['uid'],
      likes: snapshot['likes'],
      profileImage: snapshot['profileImage'],
    );
  }
}
