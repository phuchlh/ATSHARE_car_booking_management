import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RowIconTitle extends StatelessWidget {
  final String title;
  final String data;
  const RowIconTitle({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          // "Model",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data,
          // "Model",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
