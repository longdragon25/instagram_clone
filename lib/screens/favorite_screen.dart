import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/providers/post_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/favorite_card.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Post> listPost = Provider.of<PostProvider>(context).getListPost;
    var postFavorite = [];
    for (var post in listPost) {
      for (var idLike in post.likes) {
        if (idLike == FirebaseAuth.instance.currentUser!.uid) {
          postFavorite.add(post);
        }
      }
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Favorite'),
          centerTitle: false,
        ),
        body: ListView.builder(
          itemCount: postFavorite.length,
          itemBuilder: (context, index) {
            var data = postFavorite[index];
            return FavoriteCard(
              post: data,
            );
          },
        ));
  }
}
