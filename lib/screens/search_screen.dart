import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/providers/post_provider.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textSearch = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Post> listPost = Provider.of<PostProvider>(context).getListPost;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileSearchColor,
          title: TextFormField(
            controller: _textSearch,
            decoration: InputDecoration(labelText: 'Search for a user'),
            onFieldSubmitted: (_string) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
        body: isShowUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isGreaterThanOrEqualTo: _textSearch.text)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                      uid: (snapshot.data! as dynamic)
                                          .docs[index]['uid'])));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['photoUrl'],
                                ),
                                radius: 16,
                              ),
                              title: Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['username'],
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            : StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                itemCount: listPost.length,
                itemBuilder: (context, index) => Image.network(
                  listPost[index].postUrl,
                  fit: BoxFit.cover,
                ),
                staggeredTileBuilder: (index) =>
                    MediaQuery.of(context).size.width > webScreenSize
                        ? StaggeredTile.count(
                            (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                        : StaggeredTile.count(
                            (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
        // : FutureBuilder(
        //     future: FirebaseFirestore.instance
        //         .collection('posts')
        //         .orderBy('datePublished')
        //         .get(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }

        //       return StaggeredGridView.countBuilder(
        //         crossAxisCount: 3,
        //         itemCount: (snapshot.data! as dynamic).docs.length,
        //         itemBuilder: (context, index) => Image.network(
        //           (snapshot.data! as dynamic).docs[index]['postUrl'],
        //           fit: BoxFit.cover,
        //         ),
        //         staggeredTileBuilder: (index) => MediaQuery.of(context)
        //                     .size
        //                     .width >
        //                 webScreenSize
        //             ? StaggeredTile.count(
        //                 (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
        //             : StaggeredTile.count(
        //                 (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
        //         mainAxisSpacing: 8.0,
        //         crossAxisSpacing: 8.0,
        //       );
        //     },
        //   ),
        );
  }
}
