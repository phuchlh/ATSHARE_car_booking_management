import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FirebaseUpload extends StatefulWidget {
  final List<File> files;
  const FirebaseUpload({super.key, required this.files});

  @override
  State<FirebaseUpload> createState() => _FirebaseUploadState();
}

class _FirebaseUploadState extends State<FirebaseUpload> {
  Future<String> _startUpload() async {
    final _storage =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png}');
    for (int i = 0; i <= widget.files.length; i++) {
      final task = _storage.putFile(widget.files[i]);
      final snapshop = await task.whenComplete(() => null);
      final downloadUrl = await snapshop.ref.getDownloadURL();
      return downloadUrl;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
