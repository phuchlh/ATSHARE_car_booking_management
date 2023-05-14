import 'package:booking_car/constants.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SlideImage extends StatefulWidget {
  const SlideImage(
      {super.key,
      this.frontImg,
      this.backImg,
      this.leftImg,
      this.rightImg,
      this.otherImg});
  final String? frontImg;
  final String? backImg;
  final String? leftImg;
  final String? rightImg;
  final String? otherImg;
  @override
  State<SlideImage> createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listImgCar = [
      widget.frontImg.toString(),
      widget.backImg.toString(),
      widget.leftImg.toString(),
      widget.rightImg.toString(),
      widget.otherImg.toString(),
    ];
    return SizedBox(
      height: 320,
      child: ListView(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Carousel(
              dotSize: 7.0,
              onImageTap: (index) {},
              dotBgColor: Colors.transparent,
              dotIncreasedColor: Colors.blue,
              showIndicator: true,
              dotPosition: DotPosition.bottomCenter,
              dotSpacing: 15.0,
              images: [
                NetworkImage(
                    widget.frontImg == '' ? ERROR_PHOTO : widget.frontImg!),
                NetworkImage(
                    widget.backImg == '' ? ERROR_PHOTO : widget.backImg!),
                NetworkImage(
                    widget.leftImg == '' ? ERROR_PHOTO : widget.leftImg!),
                NetworkImage(
                    widget.rightImg == '' ? ERROR_PHOTO : widget.rightImg!),
                NetworkImage(
                    widget.otherImg == '' ? ERROR_PHOTO : widget.otherImg!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
