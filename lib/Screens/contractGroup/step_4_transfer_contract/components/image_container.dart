import 'package:booking_car/constants.dart';
import 'package:booking_car/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CustomImage extends StatefulWidget {
  final String imgDescription;
  final String imgName;
  const CustomImage({
    required this.imgDescription,
    required this.imgName,
    super.key,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  String checkUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {
      return ERROR_PHOTO;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        flex: 1,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Image.network(
              checkUrl(widget.imgName),
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(widget.imgDescription)
          ],
        ),
      ),
    );
  }
}
