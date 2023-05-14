import 'package:booking_car/models/rent_contract.dart';
import 'package:booking_car/resources/remote/rent_contract_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rent_contract_state.dart';

class RentContractCubit extends Cubit<RentContractState> {
  RentContractCubit() : super(RentContractState());

  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> getRentContract(int contractGroup) async {
    try {
      emit(state.copyWith(status: RentStatus.loading));
      final rentContract = await RentContractService().getRentContract(contractGroup);
      if (rentContract != null) {
        emit(state.copyWith(
          status: RentStatus.succcess,
          rentContract: rentContract,
        ));
      } else {
        emit(state.copyWith(status: RentStatus.error, message: 'Có lỗi xảy ra'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: RentStatus.error, message: e.message));
    }
  }
}
