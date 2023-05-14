// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:booking_car/blocs/cubit/receive_contract/receive_contract_cubit.dart';
import 'package:booking_car/components/take_more_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:booking_car/components/input_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DamageDescription extends StatefulWidget {
  final Function(List<File>) onImageListUpdated;
  final int statusContract;
  const DamageDescription(
      {super.key, required this.onImageListUpdated, required this.statusContract});

  @override
  State<DamageDescription> createState() => _DamageDescriptionState();
}

class _DamageDescriptionState extends State<DamageDescription> {
  @override
  Widget build(BuildContext context) {
    return widget.statusContract == 11
        ? Column(
            children: [
              TakeMorePic(
                  description: 'hư hại',
                  onImageListUpdated: widget.onImageListUpdated,
                  title: 'Thêm ảnh hư hại'),
              Padding(padding: EdgeInsets.only(top: 10)),
            ],
          )
        : // khác 11(12, 13, 16) thì load lại ảnh

        BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
            builder: (context, state) {
              return CustomTextField(
                initialText: state.response?.insuranceMoney.toString() ?? '0',
                endIcon: Text(
                  "đ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                title: 'Tiền bảo hiểm',
                keyboardType: TextInputType.number,
                onChangedString: (p0) {
                  if (p0 == null) {
                    context
                        .read<ReceiveContractCubit>()
                        .onChangeInsuranceInput(state.response?.insuranceMoney.toString());
                  } else {
                    context.read<ReceiveContractCubit>().onChangeInsuranceInput(p0);
                  }
                },
              );
            },
          );
  }
}
