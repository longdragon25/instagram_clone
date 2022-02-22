import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentId;
  final datePublished;
  final String name;
  final String profilePic;
  final String text;
  final String uid;

  Comment(
      {required this.commentId,
      required this.datePublished,
      required this.name,
      required this.profilePic,
      required this.text,
      required this.uid});

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comment(
        commentId: snapshot["commentId"],
        datePublished: snapshot["datePublished"],
        name: snapshot["name"],
        profilePic: snapshot["profilePic"],
        text: snapshot["text"],
        uid: snapshot["uid"]);
  }

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "datePublished": datePublished,
        "name": name,
        "profilePic": profilePic,
        "text": text,
        "uid": uid
      };
}
