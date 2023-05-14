import 'dart:convert';

import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/models/car.dart';
import 'package:booking_car/models/contract_group.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const CG = '/contractgroup';

final FlutterSecureStorage storage = new FlutterSecureStorage();

class ContractGroupService {
  Future<List<ContractGroup>?> getAllContractGroup() async {
    try {
      var parkinglotID = await storage.read(key: 'parkinglotID');
      final response = await DioClient.get('$CG/parking-lot-id/$parkinglotID?page=1&pageSize=100');
      if (response.statusCode == 200) {
        List<ContractGroup> data = response.data['contracts']
            .map<ContractGroup>((e) => ContractGroup.fromJson(e))
            .toList();
        return data;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<ContractGroup?> getContractGroup(int id) async {
    try {
      final response = await DioClient.get('$CG/$id');
      if (response.statusCode == 200) {
        return ContractGroup.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<ContractGroupStatus> updateStatus(int id, ContractGroup contractGroup) async {
    try {
      debugPrint('update ${contractGroup.toJson()}');
      final response = await DioClient.put('$CG/update-status/$id', contractGroup.toJson());
      if (response.statusCode == 204) {
        return ContractGroupStatus.succcess;
      }
      return ContractGroupStatus.error;
    } on DioError catch (e) {
      throw e;
    }
  }
}
