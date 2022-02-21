import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/utils/colors.dart';

class FavoriteCard extends StatelessWidget {
  Post post;
  FavoriteCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post.profImage),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('${post.username}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      '  ${post.description}',
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              child: Image.network(
                post.postUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
