import 'package:booking_car/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GridView.builder(
            itemCount: 4,
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 7 / 10.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                child: Shimmer.fromColors(
                  child: ShimmerElement(),
                  baseColor: shimmerBase,
                  highlightColor: shimmerHighlight,
                ),
              );
            }));
  }
}

class ShimmerElement extends StatefulWidget {
  const ShimmerElement({super.key});

  @override
  State<ShimmerElement> createState() => _ShimmerElementState();
}

class _ShimmerElementState extends State<ShimmerElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: 180,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 180,
                    color: Colors.grey,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 180,
                    color: Colors.grey,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 180,
                    color: Colors.grey,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 15,
                    width: 100,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
