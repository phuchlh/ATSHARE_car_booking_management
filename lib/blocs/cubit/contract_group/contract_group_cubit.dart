import 'package:bloc/bloc.dart';
import 'package:booking_car/models/contract_group.dart';
import 'package:booking_car/resources/remote/contract_group_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'contract_group_state.dart';

class ContractGroupCubit extends Cubit<ContractGroupState> {
  ContractGroupCubit() : super(ContractGroupState());

  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> getAllContractGroup() async {
    try {
      emit(state.copyWith(status: ContractGroupStatus.loading));
      final contractGroup = await ContractGroupService().getAllContractGroup();
      if (contractGroup != null) {
        emit(state.copyWith(status: ContractGroupStatus.succcess, contractGroups: contractGroup));
      } else {
        emit(state.copyWith(status: ContractGroupStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: ContractGroupStatus.error, message: e.message));
    }
  }

  Future<void> getContractGroup(int id) async {
    try {
      emit(state.copyWith(status: ContractGroupStatus.loading));
      final contractGroup = await ContractGroupService().getContractGroup(id);
      if (contractGroup != null) {
        emit(state.copyWith(status: ContractGroupStatus.succcess, contractGroup: contractGroup));
      } else {
        emit(state.copyWith(status: ContractGroupStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: ContractGroupStatus.error, message: e.message));
    }
  }

  Future<bool?> updateStatus(int id, ContractGroup contractGroupModel) async {
    try {
      emit(state.copyWith(status: ContractGroupStatus.loading));
      final contractGroup = await ContractGroupService().updateStatus(id, contractGroupModel);
      print('cubit $contractGroup');
      if (contractGroup != null) {
        emit(state.copyWith(status: ContractGroupStatus.succcess));
      } else {
        emit(state.copyWith(status: ContractGroupStatus.error, message: 'Error'));
      }
      emit(state.copyWith(status: ContractGroupStatus.error, message: 'Error'));
    } on DioError catch (e) {
      emit(state.copyWith(status: ContractGroupStatus.error, message: e.message));
    }
  }
}
