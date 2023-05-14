import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/blocs/cubit/transfer_contract/transfer_contract_cubit.dart';
import 'package:booking_car/models/contract_group.dart';
import 'package:booking_car/models/transfer_model.dart';
import 'package:booking_car/models/transfer_post.dart';
import 'package:booking_car/models/transfer_put.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:booking_car/screens/contractGroup/step_4_transfer_contract/transfer_contract.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const TRANSFER = "/transfercontract";
const getByContractGroupId = '/get-by-contractGroupId';

class TransferContractService {
  Future<TransferContractStatus> createTransferContract(TransferPost contractGroup) async {
    try {
      print(contractGroup.transferContractFileCreateModels.toString());
      final response = await DioClient.post("$TRANSFER/create", contractGroup.toJson());
      if (response.statusCode == 200) {
        return TransferContractStatus.succcess;
      } else {
        return TransferContractStatus.error;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<TransferModel?> getTransferContract(int contractGroup) async {
    try {
      final response = await DioClient.get("$TRANSFER$getByContractGroupId/$contractGroup");
      if (response.statusCode == 200) {
        return TransferModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<TransferContractStatus> updateTransferContract(TransferPut model, int transferId) async {
    try {
      final response = await DioClient.put("$TRANSFER/update/$transferId", model.toJson());
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Cập nhật thành công');
        return TransferContractStatus.succcess;
      } else {
        EasyLoading.showError('Đã có lỗi, vui lòng kiểm tra lại');
        return TransferContractStatus.error;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<TransferContractStatus> updateStatusTransferContract(
      TransferModel model, int transferID) async {
    try {
      final response =
          await DioClient.put("$TRANSFER/update-contract-status/$transferID", model.toJson());
      if (response.statusCode == 200) {
        return TransferContractStatus.succcess;
      }
      return TransferContractStatus.error;
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<TransferModel?> getTransferContractById(int id) async {
    try {
      final response = await DioClient.get('$TRANSFER/$id');
      if (response.statusCode == 200) {
        return TransferModel.fromJson(response.data);
      }

      if (response.statusCode == 404) {
        print('Không tìm thấy Transfer contract');
      }
    } on DioError catch (error) {
      throw error;
    }
  }
}
