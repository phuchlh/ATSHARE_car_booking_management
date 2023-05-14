import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Divider(
        height: 20,
        thickness: 1,
        indent: 10,
        endIndent: 10,
        color: Color.fromARGB(255, 179, 177, 177),
      ),
    );
  }
}
