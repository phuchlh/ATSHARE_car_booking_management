// ignore_for_file: body_might_complete_normally_nullable

import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/config.dart';
import 'package:booking_car/models/car.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:booking_car/models/car_schedule_model.dart';
import 'package:booking_car/models/car_schedule_post.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:booking_car/resources/remote/contract_group_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const CAR = '/car';

final FlutterSecureStorage storage = new FlutterSecureStorage();

class CarService {
  // get all Car
  // Future<List<Car>?> getAllCar(int currentPage) async {
  //   try {
  //     // final response =
  //     //     await client.get("${carAPI}all?page=$currentPage&pageSize=$pageSize");
  //     final response =
  //         await DioClient.get('$CAR/active?page=$currentPage&pageSize=$pageSize');
  //     // ?page=$currentPage&pageSize=$pageSize'
  //     if (response.statusCode == 200) {
  //       List<Car> data =
  //           response.data['cars'].map<Car>((e) => Car.fromJson(e)).toList();
  //       return data;
  //     }
  //   } on DioError catch (e) {
  //     throw e;
  //   }
  // }
  Future<List<Car>?> getAllCar(int currentPage) async {
    var value = await storage.read(key: 'accessToken');
    var parkinglotID = await storage.read(key: 'parkinglotID');
    try {
      // final response =
      //     await client.get("${carAPI}all?page=$currentPage&pageSize=$pageSize");
      // final response =
      //     await DioClient.get('$CAR/active?page=$currentPage&pageSize=$pageSize');
      final response = await DioClient.getWithToken(
          '$CAR/active?ParkingLotId=$parkinglotID&page=$currentPage&pageSize=10', value);
      // ?page=$currentPage&pageSize=$pageSize'
      if (response.statusCode == 200) {
        List<Car> data = response.data['cars'].map<Car>((e) => Car.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<Car?> getCarById(int id) async {
    try {
      final response = await DioClient.get('$CAR/$id');
      debugPrint('$CAR/$id');
      if (response.statusCode == 200) {
        debugPrint(Car.fromJson(response.data).toString());
        return Car.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<List<Car>?> getByStatus(int statusID, int page, int pageSize) async {
    try {
      final response =
          await DioClient.get('$CAR/active?CarStatusId=$statusID&page=$page&pageSize=$pageSize');
      if (response.statusCode == 200) {
        List<Car> data = response.data['cars'].map<Car>((e) => Car.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<List<Car>?> searchCar({
    String? carMake,
    int? statusID,
    String? seat,
    String? licensePlate,
  }) async {
    try {
      var parkinglotID = await storage.read(key: 'parkinglotID');
      statusID == 0 ? statusID = null : statusID = statusID;
      String url = '$CAR/active?';
      url += statusID == null ? "" : 'CarStatusId=$statusID&ParkingLotId=$parkinglotID&';
      url += licensePlate != null ? 'CarLicensePlates=$licensePlate&' : '';
      url += carMake != null ? 'CarMakeName=$carMake&' : '';
      url += seat != null ? 'SeatNumber=$seat&' : '';
      url += 'page=1&pageSize=100';
      final response = await DioClient.get(url);
      if (response.statusCode == 200) {
        List<Car> data = response.data['cars'].map<Car>((e) => Car.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<Car?> getDetailThenGetCar(int contractGroupID) async {
    try {
      final response = await DioClient.get('$CG/$contractGroupID');
      if (response.statusCode == 200) {
        final int id = response.data['carId'];
        final car = await DioClient.get('$CAR/$id');
        if (car.statusCode == 200) {
          return Car.fromJson(car.data);
        } else {
          debugPrint('loi roi');
        }
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<CarStatus> updateCarImage(int carID, Car car) async {
    try {
      final response = await DioClient.put("$CAR/update/$carID", car.toJson());
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Cập nhật thành công');
        return CarStatus.succcess;
      }
    } on DioError catch (e) {
      throw e;
    }
    return CarStatus.error;
  }

  Future<CarStatus> updateCarStatus(int carID, Car car) async {
    try {
      final response = await DioClient.put("$CAR/update-status/$carID", car.toJson());
      if (response.statusCode == 204) {
        return CarStatus.succcess;
      }
    } on DioError catch (e) {
      throw e;
    }
    return CarStatus.error;
  }
}
