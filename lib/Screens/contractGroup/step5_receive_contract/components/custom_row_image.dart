import 'package:booking_car/constants.dart';
import 'package:booking_car/models/receive_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRowImage extends StatefulWidget {
  final List<ReceiveContractFileDataModels> imageUrls;
  const CustomRowImage({
    required this.imageUrls,
    super.key,
  });

  @override
  State<CustomRowImage> createState() => _CustomRowImageState();
}

class _CustomRowImageState extends State<CustomRowImage> {
  String checkUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {
      return ERROR_PHOTO;
    }
  }

  // Image.network(checkUrl(url.documentImg ?? ""), height: 100, width: 100),
  // Padding(padding: EdgeInsets.only(top: 10)),
  // Text(url.documentDescription ?? "Hình ảnh")
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.imageUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Image.network(
              checkUrl(widget.imageUrls[index].documentImg ?? ""),
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Text('Description of image'),
          ],
        );
      },
    );
  }
}
