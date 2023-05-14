import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

// ignore: must_be_immutable
class SignaturePad extends StatefulWidget {
  File? signatureFile;
  Function? signatureFuction;
  String title;
  SignaturePad(
      {super.key, required this.signatureFile, required this.title, this.signatureFuction});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  late final GlobalKey<SfSignaturePadState> _signaturePadKey;

  @override
  void initState() {
    _signaturePadKey = GlobalKey<SfSignaturePadState>();
    super.initState();
  }

  Future<dynamic> _showSignatureDialog(BuildContext context) async {
    return showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 300,
                child: SfSignaturePad(
                  backgroundColor: Colors.white,
                  key: _signaturePadKey,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final signatureData = await _signaturePadKey.currentState!.toImage();
                  final bytes = await signatureData.toByteData(format: ImageByteFormat.png);
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      '${directory.path}/signature_${DateTime.now().microsecondsSinceEpoch}.png';
                  final file = File(imagePath);
                  await file.writeAsBytes(bytes!.buffer.asUint8List());
                  Navigator.pop(context, file);
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          child: widget.signatureFile != null
              ? Image.file(
                  widget.signatureFile!,
                  fit: BoxFit.cover,
                )
              : Container(),
        ),
        ElevatedButton(
          onPressed: () async {
            File signature = await _showSignatureDialog(context);
            if (widget.signatureFuction != null) {
              widget.signatureFuction!(signature);
            }
            setState(() {
              widget.signatureFile = signature;
            });
          },
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }
}
