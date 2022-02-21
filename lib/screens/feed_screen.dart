import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/providers/post_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    addData();
  }

  addData() async {
    PostProvider _postProvider =
        Provider.of<PostProvider>(context, listen: false);
    await _postProvider.getPost();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    PostProvider postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    FirestoreMethods().getPost();
                  },
                ),
              ],
            ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('posts')
      //       .orderBy('datePublished', descending: true)
      //       .snapshots(),
      //   builder: (context,
      //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (ctx, index) => Container(
      //         margin: EdgeInsets.symmetric(
      //           horizontal: width > webScreenSize ? width * 0.3 : 0,
      //           vertical: width > webScreenSize ? 15 : 0,
      //         ),
      //         child: PostCard(
      //           snap: snapshot.data!.docs[index].data(),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: ListView.builder(
        itemCount: postProvider.getListPost.length,
        itemBuilder: (context, index) {
          return PostCard(post: postProvider.getListPost[index]);
        },
      ),
    );
  }
}
