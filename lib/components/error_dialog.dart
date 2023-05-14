import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DialogConfirm extends StatelessWidget {
  const DialogConfirm({super.key, required this.title, required this.content});
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Text(title!),
        content: Text(content!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
