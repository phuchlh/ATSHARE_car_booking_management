import 'package:booking_car/config.dart';
import 'package:booking_car/models/car.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

const STATUS = '/carstatus';

class StatusService {
  Future<List<CarInfo>?> getInfo(String path) async {
    try {
      final response = await DioClient.get(path);
      if (response.statusCode == 200) {
        List<CarInfo> data =
            response.data.map<CarInfo>((e) => CarInfo.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
