import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class IconText extends StatelessWidget {
  final String title;
  final IconData icon;
  final FontWeight? fontWeight;
  final Color? iconColor;
  final Color? textColor;

  const IconText({
    super.key,
    required this.title,
    required this.icon,
    this.fontWeight,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor ?? Colors.black,
        ),
        Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          title,
          style: TextStyle(
              fontWeight: fontWeight ?? FontWeight.bold, color: textColor ?? Colors.black),
        ),
      ],
    );
  }
}
