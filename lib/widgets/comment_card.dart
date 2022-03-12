import 'package:flutter/material.dart';
import 'package:instagram_clone/models/comment.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  Comment comment;
  CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(comment.profilePic),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: comment.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(text: '  ${comment.text}'),
                  ])),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(comment.datePublished.toDate()),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            )),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.favorite,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
