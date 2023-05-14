import 'package:booking_car/blocs/cubit/receive_contract/receive_contract_cubit.dart';
import 'package:booking_car/models/receive_model.dart';
import 'package:booking_car/models/receive_post.dart';
import 'package:booking_car/models/receive_put.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const RC = '/receivecontract';
const createRC = '/receivecontract/create';
const getByContractGroupId = '/get-by-contractGroupId';

class ReceiveContractService {
  Future<ReceiveContractStatus> postReceiveContract(ReceivePost contract) async {
    try {
      final response = await DioClient.post(createRC, contract.toJson());
      if (response.statusCode == 200) {
        return ReceiveContractStatus.success;
      } else {
        return ReceiveContractStatus.failure;
      }
    } on DioError {
      rethrow;
    }
  }

  Future<ReceiveModel?> getDetailThenReceiveContract(int contractGroupId) async {
    try {
      final response =
          await DioClient.get('/receivecontract/get-by-contractGroupId/$contractGroupId');
      if (response.statusCode == 200) {
        debugPrint(' call api service ${ReceiveModel.fromJson(response.data)}');
        return ReceiveModel.fromJson(response.data);
      }

      if (response.statusCode == 404) {
        print('Không tìm thấy Receive contract');
      }
    } on DioError {
      rethrow;
    }
    return null;
  }

  Future<ReceiveContractStatus> updateReceiveContract(ReceivePut model, int receiveID) async {
    try {
      final response = await DioClient.put('/receivecontract/update/$receiveID', model.toJson());
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Cập nhật thành công');
        return ReceiveContractStatus.success;
      }
      return ReceiveContractStatus.failure;
    } on DioError {
      rethrow;
    }
  }
}
