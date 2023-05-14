import 'package:booking_car/screens/contractGroup/components/custom_list_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTileContract extends StatelessWidget {
  final List<String> listTitle;
  final List<String> listContent;
  final double? height;
  final bool isEnable;
  const CustomTileContract({
    super.key,
    required this.isEnable,
    this.height,
    required this.listTitle,
    required this.listContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (int i = 0; i < listTitle.length; i++)
            CustomListTitle(
              height: height,
              title: listTitle[i],
              content: listContent[i],
              isEnable: isEnable,
            ),
        ],
      ),
    );
  }
}
