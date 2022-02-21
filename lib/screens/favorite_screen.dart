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
        )
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('posts')
        //       .where('likes',
        //           arrayContains: FirebaseAuth.instance.currentUser!.uid)
        //       .snapshots(),
        //   builder: (context,
        //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: (snapshot.data! as dynamic).docs.length,
        //         itemBuilder: (context, index) {
        //           var data = (snapshot.data! as dynamic).docs[index];
        //           return FavoriteCard(
        //             snap: data,
        //           );
        //         },
        //       );
        //     }
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }
}
