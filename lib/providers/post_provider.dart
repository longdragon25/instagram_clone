import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/utils.dart';

class PostProvider with ChangeNotifier {
  List<Post>? _postList = [];

  FirestoreMethods _firestoreMethods = FirestoreMethods();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Post> get getListPost => _postList!;

  Future<void> getPost() async {
    var postList = await _firestoreMethods.getPost();
    _postList = postList;
    notifyListeners();
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    await FirestoreMethods().likePost(postId, uid, likes);
    await getPost();
  }

  Future<void> deletePost(String postId) async {
    await FirestoreMethods().deletePost(postId);
    await getPost();
  }

  Future<void> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    await FirestoreMethods()
        .uploadPost(description, file, uid, username, profImage);
    await getPost();
  }
}
