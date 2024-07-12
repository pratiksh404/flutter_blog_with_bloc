import 'package:blog/core/theme/palette.dart';
import 'package:blog/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DottedBorder(
              color: Palette.borderColor,
              dashPattern: [10, 4],
              borderType: BorderType.RRect,
              strokeCap: StrokeCap.round,
              radius: Radius.circular(10.0),
              child: Container(
                height: 150.0,
                width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 40.0),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text('Select your image.', style: TextStyle(fontSize: 15.0))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Technology',
                  'Business',
                  'Programming',
                  'Entertainment',
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Chip(
                            label: Text(e),
                            side: const BorderSide(color: Palette.borderColor),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            BlogEditor(controller: titleController, hintText: 'Blog Title')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Blog',
        child: const Icon(Icons.add),
      ),
    );
  }
}
