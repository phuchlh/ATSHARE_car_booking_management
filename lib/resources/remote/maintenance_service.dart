import 'package:booking_car/models/car.dart';
import 'package:booking_car/models/maintenance_history.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const CAR_MAINTENANCE = "/car/need-maintenance";
const CAR_MAINTENANCE_INFO = "/carmaintenanceinfo";

final FlutterSecureStorage storage = new FlutterSecureStorage();

class MaintenanceService {
  Future<List<Car>?> getCarNeedMaintenance(int page, int pageSize) async {
    var parkinglotID = await storage.read(key: 'parkinglotID');
    try {
      final response =
          await DioClient.get('$CAR_MAINTENANCE/$parkinglotID?page=$page&pageSize=$pageSize');
      if (response.statusCode == 200) {
        List<Car> data = response.data['cars'].map<Car>((e) => Car.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<List<MaintenanceHistory>?> getMaintenanceHistory(int carID) async {
    try {
      final response = await DioClient.get('$CAR_MAINTENANCE_INFO/get-by-carId/$carID');
      if (response.statusCode == 200) {
        List<MaintenanceHistory> data =
            response.data.map<MaintenanceHistory>((e) => MaintenanceHistory.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
