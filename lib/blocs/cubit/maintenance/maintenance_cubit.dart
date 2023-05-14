import 'package:bloc/bloc.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:booking_car/models/maintenance_history.dart';
import 'package:booking_car/resources/remote/car_service.dart';
import 'package:booking_car/resources/remote/maintenance_service.dart';
import 'package:booking_car/screens/maintanence/maintenance_history.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:booking_car/models/car.dart';
import 'package:flutter/cupertino.dart';

part 'maintenance_state.dart';

class MaintenanceCubit extends Cubit<MaintenanceState> {
  MaintenanceCubit() : super(MaintenanceState());

  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> getAllCarNeedMaintenance() async {
    try {
      emit(state.copyWith(status: MaintenanceStatus.loading));
      final maintenance = await MaintenanceService().getCarNeedMaintenance(1, 10);
      if (maintenance != null) {
        emit(state.copyWith(
          status: MaintenanceStatus.succcess,
          carMaintenances: maintenance,
          allCarMaintenances: List<Car>.from(state.carMaintenances)..addAll(maintenance),
          hasReachedMax: maintenance.isEmpty,
        ));
      } else {
        emit(state.copyWith(status: MaintenanceStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: MaintenanceStatus.error, message: e.message));
    }
  }

  Future<void> getMoreCarNeedMaintenance(int page) async {
    try {
      emit(state.copyWith(status: MaintenanceStatus.loading));
      final maintenance = await MaintenanceService().getCarNeedMaintenance(page, 10);
      if (maintenance != null) {
        emit(state.copyWith(
          status: MaintenanceStatus.succcess,
          allCarMaintenances: List<Car>.from(state.carMaintenances)..addAll(maintenance),
          hasReachedMax: maintenance.isEmpty,
        ));
      } else {
        emit(state.copyWith(status: MaintenanceStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: MaintenanceStatus.error, message: e.message));
    }
  }

  Future<void> getMaintenanceHistory(int carID) async {
    try {
      emit(state.copyWith(status: MaintenanceStatus.loading));
      final maintenance = await MaintenanceService().getMaintenanceHistory(carID);
      if (maintenance != null) {
        emit(state.copyWith(
          status: MaintenanceStatus.succcess,
          maintenanceHistory: maintenance,
        ));
      } else {
        emit(state.copyWith(status: MaintenanceStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: MaintenanceStatus.error, message: e.message));
    }
  }
}
