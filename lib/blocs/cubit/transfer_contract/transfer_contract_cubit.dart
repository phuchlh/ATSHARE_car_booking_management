import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:booking_car/blocs/bloc/validators.dart';
import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/models/transfer_model.dart';
import 'package:booking_car/models/transfer_post.dart';
import 'package:booking_car/models/transfer_put.dart';
import 'package:booking_car/resources/remote/transfer_contract_services.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'transfer_contract_state.dart';

class TransferContractCubit extends Cubit<TransferContractState> {
  late TransferContractState newTransferState;
  late Validators _valid;
  TransferContractCubit()
      : newTransferState = TransferContractState(),
        _valid = Validators(),
        super(TransferContractState());

  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> createTransferContract(TransferPost transfer) async {
    try {
      emit(state.copyWith(status: TransferContractStatus.loading));
      final transferContract = await TransferContractService().createTransferContract(transfer);
      // ignore: unnecessary_null_comparison
      if (transferContract != null) {
        emit(state.copyWith(
          status: TransferContractStatus.succcess,
        ));
      } else {
        emit(state.copyWith(status: TransferContractStatus.error, message: 'Có lỗi xảy ra'));
      }
      emit(state.copyWith(
        status: TransferContractStatus.succcess,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(status: TransferContractStatus.error, message: e.message));
    }
  }

  Future<void> getTransferContract(int contractGroup) async {
    try {
      emit(state.copyWith(status: TransferContractStatus.loading));
      final transferContract = await TransferContractService().getTransferContract(contractGroup);
      if (transferContract != null) {
        emit(state.copyWith(
          status: TransferContractStatus.succcess,
          transferModel: transferContract,
        ));
      } else {
        emit(state.copyWith(status: TransferContractStatus.error, message: 'Có lỗi xảy ra'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: TransferContractStatus.error, message: e.message));
    }
  }

  Future<void> updateTransferContract(TransferPut model, int transferId) async {
    try {
      emit(state.copyWith(status: TransferContractStatus.loading));
      final transferContract =
          await TransferContractService().updateTransferContract(model, transferId);
      if (transferContract == TransferContractStatus.succcess) {
        emit(state.copyWith(
          status: TransferContractStatus.succcess,
        ));
      } else {
        emit(state.copyWith(status: TransferContractStatus.error, message: 'Có lỗi xảy ra'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: TransferContractStatus.error, message: e.message));
    }
  }

  onChangeStaffSignature(File staffSignature) {
    final newStaffSig = staffSignature;
    // newTransferState = state.copyWith(staffSignature: staffSignature);
    emit(state.copyWith(staffSignature: staffSignature));
  }

  onChangeCustomerSignature(File customerSignature) {
    emit(state.copyWith(customerSignature: customerSignature));
  }

  onChangeSpeedoNumber(String? speedo) {
    int curSpeedo = 0;
    String curSpeedoParsed = speedo == "" ? "0" : speedo!;
    curSpeedo = int.tryParse(curSpeedoParsed) ?? 0;
    int prevSpeedo = int.parse(state.speedoNumber.toString());
    print('prevSpeedo transfer : $prevSpeedo');
    String? validatorMessage = _valid.speedoValid(curSpeedo, prevSpeedo);
    if (validatorMessage != null) {
      Fluttertoast.showToast(msg: validatorMessage);
    } else {
      newTransferState = state.copyWith(speedoNumber: curSpeedo);
      emit(newTransferState);
    }
  }

  onChangeFuelPercentage(String? fuel) {
    int curFuel = 0;
    String fuelParsed = fuel == "" ? "0" : fuel!;
    curFuel = int.tryParse(fuelParsed) ?? 0;
    String? validatorMessage = _valid.fuelPercentageValid(curFuel);
    if (validatorMessage == null) {
      newTransferState = state.copyWith(fuelPercentage: curFuel);
      emit(newTransferState);
    } else {
      Fluttertoast.showToast(msg: validatorMessage);
    }
  }

  onChangeETCAmount(String? etc) {
    int etcAmount = 0;
    String etcParsed = etc == "" ? "0" : etc!;
    etcAmount = int.tryParse(etcParsed) ?? 0;
    String? validatorMessage = _valid.etcAmountValid(etcAmount);
    if (validatorMessage == null) {
      newTransferState = state.copyWith(etcAmount: etcAmount);
      emit(newTransferState);
    } else {
      Fluttertoast.showToast(msg: validatorMessage);
    }
  }

  onChangeCarStatusDescription(String? statusDescription) {
    newTransferState = state.copyWith(statusDescription: statusDescription);
    emit(newTransferState);
  }
}
