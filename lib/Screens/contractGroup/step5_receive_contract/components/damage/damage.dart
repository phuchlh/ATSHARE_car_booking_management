import 'dart:io';

import 'package:booking_car/constants.dart';
import 'package:booking_car/screens/contractGroup/components/custom_big_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'damage_description.dart';

class CarDamage extends StatefulWidget {
  final bool? isExpanded;
  final int statusContract;
  final Function(List<File>) onImageListUpdated;
  final bool? isSelected;
  const CarDamage(
      {super.key,
      this.isExpanded,
      this.isSelected,
      required this.onImageListUpdated,
      required this.statusContract});

  @override
  State<CarDamage> createState() => _CarDamageState();
}

class _CarDamageState extends State<CarDamage> {
  late bool? _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          'Xe hư hại',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        DropdownButton<bool>(
          isExpanded: true,
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text('Ban đầu', style: styleTextNormal),
            ),
            DropdownMenuItem(
              value: false,
              child: Text('Thiệt hại', style: styleTextNormal),
            ),
          ],
          value: _isSelected,
          onChanged: widget.isExpanded == true
              ? (bool? value) {
                  setState(() {
                    _isSelected = value;
                  });
                }
              : null,
        ),
        _isSelected == true
            ? Container()
            : DamageDescription(
                onImageListUpdated: widget.onImageListUpdated,
                statusContract: widget.statusContract),
      ],
    );
  }
}
