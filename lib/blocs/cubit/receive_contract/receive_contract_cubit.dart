import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:booking_car/models/receive_model.dart';
import 'package:booking_car/models/receive_post.dart';
import 'package:booking_car/models/receive_put.dart';
import 'package:booking_car/resources/remote/receive_contract_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'receive_contract_state.dart';

class ReceiveContractCubit extends Cubit<ReceiveContractState> {
  late ReceiveContractState newReceiveContractState;
  ReceiveContractCubit() : super(ReceiveContractState());

  init() {
    emit(state.copyWith(isEdit: false));
    newReceiveContractState = ReceiveContractState();
    // emit(newReceiveContractState.copyWith(
    //   passingRedLights: "0",
    //   overSpeeds: "0",
    //   currentFuelMoney: 0,
    //   insurance: 0,
    //   roadViolates: "0",
    //   violationMoney: 0,
    // ));
  }

  Future<void> postReceiveContract(ReceivePost receivePost) async {
    emit(state.copyWith(status: ReceiveContractStatus.loading));
    try {
      final response = await ReceiveContractService().postReceiveContract(receivePost);
      emit(state.copyWith(status: response));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: ReceiveContractStatus.failure));
    }
  }

  Future<void> getDetailThenReceiveContract(int contractGroupId) async {
    emit(state.copyWith(status: ReceiveContractStatus.loading));
    try {
      final response = await ReceiveContractService().getDetailThenReceiveContract(contractGroupId);
      emit(state.copyWith(status: ReceiveContractStatus.success, response: response));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: ReceiveContractStatus.failure));
    }
  }

  Future<void> updateReceiveContract(ReceivePut model, int receiveId) async {
    emit(state.copyWith(status: ReceiveContractStatus.loading));
    try {
      final response = await ReceiveContractService().updateReceiveContract(model, receiveId);
      emit(state.copyWith(status: response));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: ReceiveContractStatus.failure));
    }
  }

  onChangeInsuranceInput(String? insurance) {
    int insuranceValue = 0;
    String insuranceString = insurance == '' ? "0" : insurance!;
    insuranceValue = int.parse(insuranceString);
    newReceiveContractState = state.copyWith(insurance: insuranceValue);
    emit(newReceiveContractState);
  }

  onChangeOverSpeedInput(String? overSpeed) {
    String overSpeedString = overSpeed == '' ? "0" : overSpeed!;
    newReceiveContractState = state.copyWith(overSpeeds: overSpeedString);
    emit(newReceiveContractState);
  }

  onChangeRoadViolateInput(String? trafficViolate) {
    String trafficViolateString = trafficViolate == '' ? "0" : trafficViolate!;
    newReceiveContractState = state.copyWith(roadViolates: trafficViolateString);
    emit(newReceiveContractState);
  }

  onChangePassingRedLightInput(String? passingRedLight) {
    String passingRedLightString = passingRedLight == '' ? "0" : passingRedLight!;
    newReceiveContractState = state.copyWith(passingRedLights: passingRedLightString);
    emit(newReceiveContractState);
  }

  onChangeAnotherViolationInput(String? anotherViolation) {
    String anotherViolationString = anotherViolation == '' ? "0" : anotherViolation!;
    newReceiveContractState = state.copyWith(anotherViolations: anotherViolationString);
    emit(newReceiveContractState);
  }

  onChangeReturnDepositCheck(bool isReturn) {
    newReceiveContractState = state.copyWith(isReturnDeposit: isReturn);
    emit(newReceiveContractState);
  }

  onChangeTrafficViolationCheck(bool isViolation) {
    newReceiveContractState = state.copyWith(isTrafficViolation: isViolation);
    emit(newReceiveContractState);
  }

  onChangeOverHourCheck(String? overHour) {
    int overHourValue = int.parse((overHour?.trim()) == '' ? "0" : (overHour!.trim()));
    newReceiveContractState = state.copyWith(overHours: overHourValue);
    emit(newReceiveContractState);
  }

  onChangeViolationMoneyCheck(String? violationMoney) {
    int violationMoneyValue = 0;
    String anotherViolationString = violationMoney == '' ? "0" : violationMoney!;
    violationMoneyValue = int.parse(anotherViolationString);
    newReceiveContractState = state.copyWith(violationMoney: violationMoneyValue);
    emit(newReceiveContractState);
  }

  onChangeFuelMoneyCheck(String? currFuelMoney) {
    int fuelMoney = 0;
    String fuelMoneyString = currFuelMoney == '' ? "0" : currFuelMoney!;
    fuelMoney = int.parse(fuelMoneyString);
    print('current fuel money $fuelMoney');
    newReceiveContractState = state.copyWith(currentFuelMoney: fuelMoney);
    emit(newReceiveContractState);
  }
}
