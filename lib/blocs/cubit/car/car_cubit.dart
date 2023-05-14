import 'package:bloc/bloc.dart';
import 'package:booking_car/blocs/bloc/validators.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:booking_car/models/car_schedule_model.dart';
import 'package:booking_car/models/car_schedule_post.dart';
import 'package:booking_car/resources/remote/car_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:booking_car/models/car.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  late Validators _valid;
  late CarState newCarState;
  CarCubit()
      : _valid = Validators(),
        newCarState = CarState(),
        super(CarState(
          // speedoNumber: 0,
          // fuelPercentage: 0,
          // etcAmount: 0,
          // statusDescription: '',
          hasReachedMax: false,
          isLoading: false,
        ));

  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> getAllCar(int currentPage, int pageSize) async {
    try {
      if (currentPage > 1) {
        emit(state.copyWith(status: CarStatus.loadMore));
      } else if (currentPage == 1) {
        emit(state.copyWith(status: CarStatus.loading));
      }
      final carsFetch = await CarService().getAllCar(currentPage);
      if (carsFetch != null) {
        final allCars = List<Car>.from(state.cars)..addAll(carsFetch);
        emit(state.copyWith(
          status: CarStatus.succcess,
          cars: allCars,
          allCars: allCars,
          hasReachedMax: carsFetch.isEmpty,
          // load hết 1 trang -> car.isEmpty = false -> chưa hêt data
          // khi load tới trang cuối, car.isEmpty = true -> hết data
        ));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }

  Future<void> getMore(int currentPage, int pageSize) async {
    if (state.isLoading || state.hasReachedMax) return;
    try {
      emit(state.copyWith(status: CarStatus.loading));
      final carsFetch = await CarService().getAllCar(currentPage);

      if (carsFetch != null) {
        final allCars = List<Car>.from(state.allCars)..addAll(carsFetch);
        emit(state.copyWith(
          status: CarStatus.succcess,
          // cars: allCars,
          allCars: allCars,
          hasReachedMax: carsFetch.isEmpty,
          // load hết 1 trang -> car.isEmpty = false -> chưa hêt data
          // khi load tới trang cuối, car.isEmpty = true -> hết data
        ));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }

  Future<void> getCarById(int id) async {
    try {
      emit(state.copyWith(
          status: CarStatus.loading, speedoNumber: 0, fuelPercentage: 0, etcAmount: 0));
      final car = await CarService().getCarById(id);
      if (car != null) {
        emit(state.copyWith(
            status: CarStatus.succcess,
            car: car,
            speedoNumber: car.speedometerNumber,
            fuelPercentage: car.fuelPercent,
            etcAmount: car.currentEtcAmount));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }

  Future<void> getByStatus(int id) async {
    try {
      emit(state.copyWith(status: CarStatus.loading));
      final car = await CarService().getByStatus(id, 1, 100);
      if (car != null) {
        emit(state.copyWith(status: CarStatus.succcess, allCars: car));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }

  Future<void> searchCar(
      {String? carMakeName, String? seat, int? statusID, String? licensePlate}) async {
    try {
      emit(state.copyWith(status: CarStatus.loading));
      emit(state.copyWith(searchString: licensePlate));
      final car = await CarService().searchCar(
        carMake: carMakeName,
        statusID: statusID,
        seat: seat,
        licensePlate: licensePlate,
      );
      if (car != null) {
        emit(state.copyWith(status: CarStatus.succcess, allCars: car));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }

  // khi submit ở search bar, nó sẽ vào cái này
  // -> từ đây sẽ searchCar theo điều kiện của searchString và filter
  onChangeSearchString(String? value) {
    String? validatorMessage = _valid.licensePlateValid(value ?? "");
    if (validatorMessage == null) {
      emit(state.copyWith(searchString: value));
      searchCar(licensePlate: value);
      return;
    } else {
      Fluttertoast.showToast(msg: validatorMessage);
    }
  }

  onChangeFilterCheck(String? value) {
    emit(state.copyWith(filter: value));
  }

  onChangeSpeedoNumber(String? speedo) {
    print('speedo: $speedo');
    int curSpeedo = 0;
    String curSpeedoParsed = speedo == "" ? "0" : speedo!;
    curSpeedo = int.tryParse(curSpeedoParsed) ?? 0;
    int prevSpeedo = int.parse(state.car?.speedometerNumber.toString() ?? "");
    print('prevSpeedo: $prevSpeedo');
    print('curSpeedo: $curSpeedo');
    String? validatorMessage = _valid.speedoValid(curSpeedo, prevSpeedo);
    if (validatorMessage != null) {
      Fluttertoast.showToast(msg: validatorMessage);
    } else {
      newCarState = state.copyWith(speedoNumber: curSpeedo);
      emit(newCarState);
      debugPrint('new state speedo: ${newCarState.speedoNumber}');
    }
  }

  onChangeFuelPercentage(String? fuel) {
    print('fuel: $fuel');
    int curFuel = 0;
    String fuelParsed = fuel == "" ? "0" : fuel!;
    curFuel = int.tryParse(fuelParsed) ?? 0;
    String? validatorMessage = _valid.fuelPercentageValid(curFuel);
    if (validatorMessage == null) {
      newCarState = state.copyWith(fuelPercentage: curFuel);
      emit(newCarState);
    } else {
      Fluttertoast.showToast(msg: validatorMessage);
    }
  }

  onChangeETCAmount(String? etc) {
    print('etc: $etc');
    int etcAmount = 0;
    String etcParsed = etc == "" ? "0" : etc!;
    etcAmount = int.tryParse(etcParsed) ?? 0;
    String? validatorMessage = _valid.etcAmountValid(etcAmount);
    if (validatorMessage == null) {
      newCarState = state.copyWith(etcAmount: etcAmount);
      emit(newCarState);
    } else {
      Fluttertoast.showToast(msg: validatorMessage);
    }
  }

  onChangeCarStatusDescription(String? statusDescription) {
    print('statusDescription: $statusDescription');
    newCarState = state.copyWith(statusDescription: statusDescription);
    emit(newCarState);
  }

  Future<void> getDetailThenGetCar(int contractId) async {
    try {
      emit(state.copyWith(status: CarStatus.loading));
      final car = await CarService().getDetailThenGetCar(contractId);
      if (car != null) {
        emit(state.copyWith(status: CarStatus.succcess, car: car));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }

  Future<void> updateCarImage(int carID, Car carObj) async {
    try {
      emit(state.copyWith(status: CarStatus.loading));
      final car = await CarService().updateCarImage(carID, carObj);
      // ignore: unnecessary_null_comparison
      if (car != null) {
        emit(state.copyWith(status: CarStatus.succcess, message: 'Success'));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }

  Future<void> updateCarStatus(int carID, Car carObj) async {
    try {
      emit(state.copyWith(status: CarStatus.loading));
      final car = await CarService().updateCarStatus(carID, carObj);
      // ignore: unnecessary_null_comparison
      if (car != null) {
        emit(state.copyWith(status: CarStatus.succcess, message: 'Success'));
      } else {
        emit(state.copyWith(status: CarStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarStatus.error, message: e.message));
    }
  }
}
