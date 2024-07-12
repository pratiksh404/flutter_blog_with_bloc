import 'package:blog/features/blog/presentation/pages/add_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogHome extends StatelessWidget {
  const BlogHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Blog App'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context, AddBlogPage.route());
            },
            icon: const Icon(CupertinoIcons.add_circled))
      ],
    ));
  }
}
