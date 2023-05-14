import 'dart:io';

import 'package:booking_car/blocs/cubit/receive_contract/receive_contract_cubit.dart';
import 'package:booking_car/screens/contractGroup/step5_receive_contract/components/damage/damage.dart';
import 'package:booking_car/screens/contractGroup/step5_receive_contract/components/traffic_violation/traffic_violation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:booking_car/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnDepositCheck extends StatefulWidget {
  final bool? isReturnDep;
  final Function(List<File>) onImageListUpdated;
  final bool? setEnabled;
  final int statusContract;

  const ReturnDepositCheck(
      {super.key,
      this.isReturnDep,
      this.setEnabled,
      required this.statusContract,
      required this.onImageListUpdated});

  @override
  State<ReturnDepositCheck> createState() => _ReturnDepositCheckState();
}

class _ReturnDepositCheckState extends State<ReturnDepositCheck> {
  late bool? _isReturnDep;

  @override
  void initState() {
    _isReturnDep = widget.isReturnDep ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<bool>(
          isExpanded: true,
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text('Hoàn cọc', style: styleTextNormal),
            ),
            DropdownMenuItem(
              value: false,
              child: Text('Không hoàn cọc', style: styleTextNormal),
            ),
          ],
          value: _isReturnDep,
          onChanged: widget.setEnabled == true
              ? (bool? value) {
                  context.read<ReceiveContractCubit>().onChangeReturnDepositCheck(value ?? true);
                  setState(() {
                    _isReturnDep = value;
                  });
                }
              : null,
        ),
        _isReturnDep == true
            ? Container()
            : Column(
                children: [
                  // hư hại
                  widget.statusContract == 11
                      ? CarDamage(
                          onImageListUpdated: widget.onImageListUpdated,
                          isExpanded: true,
                          isSelected: true,
                          statusContract: widget.statusContract,
                        )
                      : widget.statusContract == 16
                          ? BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                              builder: (context, state) {
                                return CarDamage(
                                  onImageListUpdated: widget.onImageListUpdated,
                                  isExpanded: false,
                                  isSelected: false,
                                  statusContract: widget.statusContract,
                                );
                              },
                            )
                          : Container(),
                  // vi phạm giao thông
                  widget.statusContract == 11
                      ? TrafficViolation(
                          statusContract: widget.statusContract,
                          onImageListUpdated: widget.onImageListUpdated,
                          isExpanded: true,
                          isSelected: false,
                        )
                      : widget.statusContract == 16
                          ? BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                              builder: (context, state) {
                                bool isTrafficViolate = true;
                                return TrafficViolation(
                                  statusContract: widget.statusContract,
                                  onImageListUpdated: widget.onImageListUpdated,
                                  isExpanded: false,
                                  isSelected: isTrafficViolate,
                                );
                              },
                            )
                          : Container(),
                ],
              ),
      ],
    );
  }
}
