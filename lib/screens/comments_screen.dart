import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/comment.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/post_provider.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentEdittingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentEdittingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    List<Post> postList = Provider.of<PostProvider>(context).getListPost;
    Post? post;
    for (var item in postList) {
      if (item.postId == widget.postId) {
        post = item;
      }
    }

    List<Comment> commentList = post!.comments;
    commentList.sort((a, b) {
      var adate = a.datePublished;
      var bdate = b.datePublished;
      return bdate.compareTo(adate);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: post.comments.length,
        itemBuilder: (context, index) {
          return CommentCard(comment: post!.comments[index]);
        },
      ),
      // StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('posts')
      //       .doc(widget.postId)
      //       .collection('comments')
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
      //       itemBuilder: (context, index) {
      //         return CommentCard(snap: snapshot.data!.docs[index]);
      //       },
      //     );
      //   },
      // ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  controller: commentEdittingController,
                  decoration: InputDecoration(
                      hintText: 'Comments as ${user.username}',
                      border: InputBorder.none),
                ),
              )),
              InkWell(
                onTap: () {
                  Provider.of<PostProvider>(context, listen: false).postComment(
                      widget.postId,
                      commentEdittingController.text,
                      user.uid,
                      user.username,
                      user.photoUrl);
                  setState(() {
                    commentEdittingController.text = "";
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
