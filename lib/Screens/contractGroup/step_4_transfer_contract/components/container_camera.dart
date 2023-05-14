import 'package:booking_car/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CustomCamera extends StatefulWidget {
  final bool? isTakenPicture;
  final String imgDescription;
  final Function? setFront;
  final Function? setBack;
  final Function? setLeft;
  final Function? setRight;
  final Function? setInside;
  final Function? setDashboard;
  final Function? setPhysicalDamage;
  final void Function(File) onPictureTaken;
  final void Function(File) onPictureDeleted;
  // final Function bulkSet;
  const CustomCamera({
    super.key,
    // required this.bulkSet,
    this.setFront,
    required this.onPictureDeleted,
    this.setBack,
    this.setLeft,
    this.setRight,
    this.setInside,
    this.setDashboard,
    this.setPhysicalDamage,
    this.isTakenPicture,
    required this.onPictureTaken,
    required this.imgDescription,
  });

  @override
  State<CustomCamera> createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {
  File? imageFile;
  late String image;

  void _openCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
    if (pickedFile == null) return;
    setState(() {
      // ignore: unnecessary_null_comparison
      imageFile = File(pickedFile.path);
    });

    if (widget.onPictureTaken != null) {
      widget.onPictureTaken(imageFile!);
    }
    widget.setFront != null
        ? widget.setFront!(imageFile)
        : widget.setBack != null
            ? widget.setBack!(imageFile)
            : widget.setLeft != null
                ? widget.setLeft!(imageFile)
                : widget.setRight != null
                    ? widget.setRight!(imageFile)
                    : widget.setInside != null
                        ? widget.setInside!(imageFile)
                        : widget.setDashboard != null
                            ? widget.setDashboard!(imageFile)
                            : widget.setPhysicalDamage != null
                                ? widget.setPhysicalDamage!(imageFile)
                                : null;

    debugPrint('imageFile: $imageFile - pickedFile $pickedFile ');
  }

  void _deleteImage() {
    if (imageFile != null) {
      widget.onPictureDeleted(imageFile!);
      setState(() {
        imageFile = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageFile == null
            ? IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () async {
                  _openCamera();
                },
              )
            : SizedBox(
                height: 150,
                width: 150,
                child: GestureDetector(
                  onTap: () async {
                    _deleteImage();
                    Fluttertoast.showToast(msg: 'Chụp lại ảnh');
                    _openCamera();
                  },
                  onLongPress: () async {
                    _deleteImage();
                    setState(() {
                      imageFile = null;
                      Fluttertoast.showToast(msg: 'Đã xóa ảnh');
                    });
                  },
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text(widget.imgDescription)),
      ],
    );
  }
}
