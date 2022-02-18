import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class FavoriteCard extends StatelessWidget {
  final snap;
  const FavoriteCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(snap['profImage']),
                ),
                const SizedBox(
                  width: 5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '  ${snap['description']}')
                  ]),
                ),
              ],
            ),
            Container(
              width: 100,
              height: 100,
              child: Image.network(
                snap['postUrl'],
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
