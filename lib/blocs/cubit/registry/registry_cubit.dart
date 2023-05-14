import 'package:bloc/bloc.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:booking_car/resources/remote/car_service.dart';
import 'package:booking_car/resources/remote/registry_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:booking_car/models/car.dart';
import 'package:flutter/cupertino.dart';

part 'registry_state.dart';

class RegistryCubit extends Cubit<RegistryState> {
  RegistryCubit() : super(RegistryState());

  init() {
    emit(state.copyWith(status: RegistryStatus.initial));
  }

  Future<void> getAllCarNeedRegistry(int currentPage) async {
    try {
      emit(state.copyWith(status: RegistryStatus.loading));
      final registry = await RegistryService().getAllCarNeedRegistry(currentPage);
      if (registry != null) {
        emit(state.copyWith(
          status: RegistryStatus.succcess,
          carRegistries: registry,
          allCarRegistries: List<Car>.from(state.carRegistries)..addAll(registry),
          hasReachedMax: registry.isEmpty,
          // load hết 1 trang -> car.isEmpty = false -> chưa hêt data
          // khi load tới trang cuối, car.isEmpty = true -> hết data
        ));
      } else {
        emit(state.copyWith(status: RegistryStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: RegistryStatus.error, message: e.message));
    }
  }

  Future<void> getMoreCarNeedRegistry(int currentPage) async {
    try {
      emit(state.copyWith(status: RegistryStatus.loading));
      final registry = await RegistryService().getAllCarNeedRegistry(currentPage);
      if (registry != null) {
        emit(state.copyWith(
          status: RegistryStatus.succcess,
          allCarRegistries: List<Car>.from(state.carRegistries)..addAll(registry),
          hasReachedMax: registry.isEmpty,
          // load hết 1 trang -> car.isEmpty = false -> chưa hêt data
          // khi load tới trang cuối, car.isEmpty = true -> hết data
        ));
      } else {
        emit(state.copyWith(status: RegistryStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: RegistryStatus.error, message: e.message));
    }
  }
}
