import 'package:booking_car/models/car.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';

const CAR_REGISTRY = "/car/need-registry";

class RegistryService {
  Future<List<Car>?> getAllCarNeedRegistry(int currentPage) async {
    try {
      final response = await DioClient.get('$CAR_REGISTRY?page=$currentPage&pageSize=10');
      if (response.statusCode == 200) {
        List<Car> data = response.data['cars'].map<Car>((e) => Car.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
