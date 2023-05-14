import 'package:booking_car/blocs/cubit/car_expense/car_expense_cubit.dart';
import 'package:booking_car/models/car_schedule_model.dart';
import 'package:booking_car/models/car_schedule_post.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const SCHEDULE = '/carschedule';

class CarScheduleService {
  Future<CarExpenseStatus> createCarSchedule(CarSchedulePost carPost) async {
    try {
      print('carPost.toJson()');
      final response = await DioClient.post("$SCHEDULE/create", carPost.toJson());
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Cập nhật thành công');
        return CarExpenseStatus.succcess;
      }
    } on DioError catch (e) {
      throw e;
    }
    return CarExpenseStatus.error;
  }

  Future<List<CarScheduleModel>?> getCarSchedule(int carID) async {
    try {
      print('carPost.toJson()');
      final response = await DioClient.get("$SCHEDULE/carId/$carID");
      if (response.statusCode == 200) {
        List<CarScheduleModel> data =
            response.data.map<CarScheduleModel>((e) => CarScheduleModel.fromJson(e)).toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
