// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:booking_car/blocs/cubit/receive_contract/receive_contract_cubit.dart';
import 'package:booking_car/components/input_text_field.dart';
import 'package:booking_car/components/take_more_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrafficViolationDescription extends StatefulWidget {
  final Function(List<File>) onImageListUpdated;
  final int statusContract;
  const TrafficViolationDescription(
      {super.key, required this.onImageListUpdated, required this.statusContract});

  @override
  State<TrafficViolationDescription> createState() => _TrafficViolationDescriptionState();
}

class _TrafficViolationDescriptionState extends State<TrafficViolationDescription> {
  @override
  Widget build(BuildContext context) {
    return widget.statusContract == 11
        ? Column(
            children: [
              CustomTextField(
                endIcon: Text(
                  "lần",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                title: 'Vượt quá tốc độ',
                keyboardType: TextInputType.number,
                onChangedString: (p0) {
                  context.read<ReceiveContractCubit>().onChangeOverSpeedInput(p0);
                },
              ),
              CustomTextField(
                endIcon: Text(
                  "lần",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                title: 'Vượt đèn giao thông',
                keyboardType: TextInputType.number,
                onChangedString: (p0) {
                  context.read<ReceiveContractCubit>().onChangePassingRedLightInput(p0);
                },
              ),
              CustomTextField(
                maxLines: 3,
                title: 'Đi vào đường cấm',
                keyboardType: TextInputType.text,
                onChangedString: (p0) {
                  context.read<ReceiveContractCubit>().onChangeRoadViolateInput(p0);
                },
              ),
              CustomTextField(
                title: 'Vi phạm khác',
                keyboardType: TextInputType.text,
                onChangedString: (p0) {
                  context.read<ReceiveContractCubit>().onChangeAnotherViolationInput(p0);
                },
              ),
            ],
          )
        : // khác 11(12, 13, 16) thì load lại ảnh
        widget.statusContract == 16
            ? BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomTextField(
                        initialText: state.response?.speedingViolationDescription ?? '0',
                        title: 'Vượt quá tốc độ',
                        keyboardType: TextInputType.number,
                        onChangedString: (p0) {
                          if (p0 == null) {
                            context.read<ReceiveContractCubit>().onChangeOverSpeedInput(
                                state.response?.speedingViolationDescription);
                          } else {
                            context.read<ReceiveContractCubit>().onChangeOverSpeedInput(p0);
                          }
                        },
                      ),
                      CustomTextField(
                        initialText: state.response?.trafficLightViolationDescription ?? '0',
                        title: 'Vượt đèn giao thông',
                        keyboardType: TextInputType.number,
                        onChangedString: (p0) {
                          if (p0 == null) {
                            context.read<ReceiveContractCubit>().onChangePassingRedLightInput(
                                state.response?.trafficLightViolationDescription);
                          } else {
                            context.read<ReceiveContractCubit>().onChangePassingRedLightInput(p0);
                          }
                        },
                      ),
                      CustomTextField(
                        initialText:
                            state.response?.forbiddenRoadViolationDescription ?? 'Không có',
                        title: 'Đi vào đường cấm',
                        keyboardType: TextInputType.text,
                        onChangedString: (p0) {
                          if (p0 == null) {
                            context.read<ReceiveContractCubit>().onChangeRoadViolateInput(
                                state.response?.forbiddenRoadViolationDescription);
                          } else {
                            context.read<ReceiveContractCubit>().onChangeRoadViolateInput(p0);
                          }
                        },
                      ),
                      CustomTextField(
                        initialText: state.response?.ortherViolation ?? 'Không có',
                        title: 'Vi phạm khác',
                        keyboardType: TextInputType.text,
                        onChangedString: (p0) {
                          if (p0 == null) {
                            context
                                .read<ReceiveContractCubit>()
                                .onChangeAnotherViolationInput(state.response?.ortherViolation);
                          } else {
                            context.read<ReceiveContractCubit>().onChangeAnotherViolationInput(p0);
                          }
                        },
                      ),
                      CustomTextField(
                        initialText: state.response?.violationMoney.toString() ?? '0',
                        endIcon: Text(
                          "đ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        title: 'Tổng tiền vi phạm',
                        keyboardType: TextInputType.number,
                        onChangedString: (p0) {
                          if (p0 == null) {
                            context.read<ReceiveContractCubit>().onChangeViolationMoneyCheck(
                                state.response?.violationMoney.toString());
                          } else {
                            context.read<ReceiveContractCubit>().onChangeViolationMoneyCheck(p0);
                          }
                        },
                      ),
                    ],
                  );
                },
              )
            : widget.statusContract == 17
                ? BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                    builder: (context, state) {
                    return CustomTextField(
                      initialText: state.response?.violationMoney.toString() ?? '0',
                      endIcon: Text(
                        "đ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      title: 'Tổng tiền vi phạm',
                      keyboardType: TextInputType.number,
                      onChangedString: (p0) {
                        if (p0 == null) {
                          context.read<ReceiveContractCubit>().onChangeViolationMoneyCheck(
                              state.response?.violationMoney.toString());
                        } else {
                          context.read<ReceiveContractCubit>().onChangeViolationMoneyCheck(p0);
                        }
                      },
                    );
                  })
                : Container();
  }
}
