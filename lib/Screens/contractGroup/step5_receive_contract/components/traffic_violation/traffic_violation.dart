import 'dart:io';

import 'package:booking_car/blocs/cubit/receive_contract/receive_contract_cubit.dart';
import 'package:booking_car/screens/contractGroup/step5_receive_contract/components/traffic_violation/traffic_violation_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:booking_car/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrafficViolation extends StatefulWidget {
  final bool? isExpanded;
  final bool? isSelected;
  final int statusContract;
  final Function(List<File>) onImageListUpdated;
  const TrafficViolation(
      {super.key,
      this.isExpanded,
      required this.statusContract,
      this.isSelected,
      required this.onImageListUpdated});

  @override
  State<TrafficViolation> createState() => _TrafficViolationState();
}

class _TrafficViolationState extends State<TrafficViolation> {
  late bool? _isSelected;
  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          'Vi phạm giao thông',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        DropdownButton<bool>(
          isExpanded: true,
          items: const [
            DropdownMenuItem(
              value: false,
              child: Text('Không vi phạm', style: styleTextNormal),
            ),
            DropdownMenuItem(
              value: true,
              child: Text('Vi phạm', style: styleTextNormal),
            ),
          ],
          value: _isSelected,
          onChanged: widget.isExpanded == true
              ? (bool? value) {
                  context.read<ReceiveContractCubit>().onChangeTrafficViolationCheck(value ?? true);
                  setState(() {
                    _isSelected = value;
                  });
                }
              : null,
        ),
        _isSelected == false
            ? Container()
            : TrafficViolationDescription(
                onImageListUpdated: widget.onImageListUpdated,
                statusContract: widget.statusContract,
              ),
      ],
    );
  }
}
