import 'package:booking_car/models/rent_contract.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';

const RC = '/rentcontract';

class RentContractService {
  Future<RentContract?> getRentContract (int contractGroup) async {
    try {
      final response =
          await DioClient.get("$RC/last/contractGroupId/$contractGroup");
      if (response.statusCode == 200) {
        return RentContract.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
