import 'dart:io';

import 'package:booking_car/screens/contractGroup/step_4_transfer_contract/components/container_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TakeMorePic extends StatefulWidget {
  final Function(List<File>) onImageListUpdated;
  final String? title;
  final String? description;
  TakeMorePic({super.key, required this.onImageListUpdated, this.title, this.description});

  @override
  State<TakeMorePic> createState() => _TakeMorePicState();
}

class _TakeMorePicState extends State<TakeMorePic> {
  List<File> imageFiles = [];
  List<Widget> rows = [];

  void _addRow() {
    String imgDescription = "";
    if (widget.description != null) {
      imgDescription = 'Ảnh ${widget.description}';
    } else {
      imgDescription = 'Ảnh ';
    }
    setState(() {
      rows.add(CustomCamera(
        imgDescription: '$imgDescription ${imageFiles.length + 1}',
        onPictureTaken: (File imageFile) {
          imageFiles.add(imageFile);
          widget.onImageListUpdated(imageFiles);
        },
        onPictureDeleted: (File imageFile) {
          imageFiles.remove(imageFile);
          widget.onImageListUpdated(imageFiles);
          setState(() {
            rows.removeWhere((widget) => widget.key == Key(imageFile.path));
          });
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ...rows,
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _addRow();
              },
              child: Text(widget.title ?? 'Thêm ảnh'),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text('Nhấn để chụp lại ảnh, giữ để xóa *',
                style: TextStyle(color: Colors.red, fontSize: 14, fontStyle: FontStyle.italic)),
          ],
        )
      ],
    );
  }
}
