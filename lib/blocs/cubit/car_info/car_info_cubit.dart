import 'package:bloc/bloc.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:booking_car/resources/remote/car_service.dart';
import 'package:booking_car/resources/remote/car_status_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:booking_car/models/car.dart';

part 'car_info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoState());

  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> getInfo(String path) async {
    try {
      emit(state.copyWith(status: InfoLoading.loading));
      final status = await StatusService().getInfo(path);
      if (status != null) {
        emit(state.copyWith(status: InfoLoading.succcess, carStatus: status));
      } else {
        emit(state.copyWith(status: InfoLoading.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: InfoLoading.error, message: e.message));
    }
  }

  Future<void> getCarMake(String path) async {
    try {
      emit(state.copyWith(status: InfoLoading.loading));
      final carMake = await StatusService().getInfo(path);
      if (carMake != null) {
        emit(state.copyWith(status: InfoLoading.succcess, carMake: carMake));
      } else {
        emit(state.copyWith(status: InfoLoading.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: InfoLoading.error, message: e.message));
    }
  }
}
