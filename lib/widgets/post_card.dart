import 'package:flutter/material.dart';
import 'package:gdsc_mobile_project/utils/app_style.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String description;
  const PostCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber[400],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: Styles.titleText,
            ),
            Text(
              description,
              style: Styles.descriptionText,
            )
          ]),
        ),
      )
    ]);
  }
}
