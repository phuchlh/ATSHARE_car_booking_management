import 'package:booking_car/components/back_to_previous_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:material/material.dart';

class PdfReader extends StatefulWidget {
  final String? pdfUrl;
  const PdfReader({super.key, required this.pdfUrl});

  @override
  State<PdfReader> createState() => _PdfReaderState();
}

class _PdfReaderState extends State<PdfReader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          if (widget.pdfUrl != null)
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SfPdfViewer.network(widget.pdfUrl!),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: PreviousPage(),
          )
        ],
      ),
    );
  }
}
