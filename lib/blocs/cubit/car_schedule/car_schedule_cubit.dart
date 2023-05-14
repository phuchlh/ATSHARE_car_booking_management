import 'package:booking_car/models/car_schedule_model.dart';
import 'package:booking_car/models/car_schedule_post.dart';
import 'package:booking_car/resources/remote/car_schedule_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_schedule_state.dart';

class CarScheduleCubit extends Cubit<CarScheduleState> {
  CarScheduleCubit() : super(CarScheduleState());
  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> createCarSchedule(CarSchedulePost carSchedule) async {
    try {
      emit(state.copyWith(status: CarScheduleStatus.loading));
      final car = await CarScheduleService().createCarSchedule(carSchedule);
      // ignore: unnecessary_null_comparison
      if (car != null) {
        emit(state.copyWith(status: CarScheduleStatus.succcess, message: 'Success'));
      } else {
        emit(state.copyWith(status: CarScheduleStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarScheduleStatus.error, message: e.message));
    }
  }

  Future<void> getCarSchedule(int carID) async {
    try {
      emit(state.copyWith(status: CarScheduleStatus.loading));
      final car = await CarScheduleService().getCarSchedule(carID);
      // ignore: unnecessary_null_comparison
      if (car != null) {
        emit(state.copyWith(
            status: CarScheduleStatus.succcess, message: 'Success', listSchedule: car));
      } else {
        emit(state.copyWith(status: CarScheduleStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarScheduleStatus.error, message: e.message));
    }
  }
}
