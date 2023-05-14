import 'dart:convert';

import 'package:booking_car/models/transfer_contract_files_data_model.dart';

class TransferModel {
  int? id;
  int? transfererId;
  String? transfererName;
  String? transfererPhoneNumber;
  int? contractGroupId;
  String? customerName;
  String? customerPhoneNumber;
  String? customerAddress;
  String? customerCitizenIdentificationInfoNumber;
  String? customerCitizenIdentificationInfoAddress;
  String? customerCitizenIdentificationInfoDateReceive;
  String? modelName;
  String? carLicensePlates;
  int? seatNumber;
  String? dateTransfer;
  String? deliveryAddress;
  int? currentCarStateSpeedometerNumber;
  int? currentCarStateFuelPercent;
  int? currentCarStateCurrentEtcAmount;
  String? currentCarStateCarStatusDescription;
  int? depositItemDownPayment;
  String? depositItemAsset;
  String? depositItemDescription;
  bool? isExported;
  String? customerSignature;
  String? staffSignature;
  String? filePath;
  String? fileWithSignsPath;
  int? contractStatusId;
  String? createdDate;
  List<TransferContractFileDataModels>? transferContractFileDataModels;

  TransferModel({
    this.id,
    this.transfererId,
    this.transfererName,
    this.transfererPhoneNumber,
    this.contractGroupId,
    this.customerName,
    this.customerPhoneNumber,
    this.customerAddress,
    this.customerCitizenIdentificationInfoNumber,
    this.customerCitizenIdentificationInfoAddress,
    this.customerCitizenIdentificationInfoDateReceive,
    this.modelName,
    this.carLicensePlates,
    this.seatNumber,
    this.dateTransfer,
    this.deliveryAddress,
    this.currentCarStateSpeedometerNumber,
    this.currentCarStateFuelPercent,
    this.currentCarStateCurrentEtcAmount,
    this.currentCarStateCarStatusDescription,
    this.depositItemDownPayment,
    this.depositItemAsset,
    this.depositItemDescription,
    this.isExported,
    this.customerSignature,
    this.staffSignature,
    this.filePath,
    this.fileWithSignsPath,
    this.contractStatusId,
    this.transferContractFileDataModels,
    this.createdDate,
  });

  TransferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transfererId = json['transfererId'];
    transfererName = json['transfererName'];
    transfererPhoneNumber = json['transfererPhoneNumber'];
    contractGroupId = json['contractGroupId'];
    customerName = json['customerName'];
    customerPhoneNumber = json['customerPhoneNumber'];
    customerAddress = json['customerAddress'];
    customerCitizenIdentificationInfoNumber =
        json['customerCitizenIdentificationInfoNumber'];
    customerCitizenIdentificationInfoAddress =
        json['customerCitizenIdentificationInfoAddress'];
    customerCitizenIdentificationInfoDateReceive =
        json['customerCitizenIdentificationInfoDateReceive'];
    modelName = json['modelName'];
    carLicensePlates = json['carLicensePlates'];
    seatNumber = json['seatNumber'];
    dateTransfer = json['dateTransfer'];
    deliveryAddress = json['deliveryAddress'];
    currentCarStateSpeedometerNumber = json['currentCarStateSpeedometerNumber'];
    currentCarStateFuelPercent = json['currentCarStateFuelPercent'];
    currentCarStateCurrentEtcAmount = json['currentCarStateCurrentEtcAmount'];
    currentCarStateCarStatusDescription =
        json['currentCarStateCarStatusDescription'];
    depositItemDownPayment = json['depositItemDownPayment'];
    depositItemAsset = json['depositItemAsset'];
    depositItemDescription = json['depositItemDescription'];
    isExported = json['isExported'];
    customerSignature = json['customerSignature'];
    staffSignature = json['staffSignature'];
    filePath = json['filePath'];
    fileWithSignsPath = json['fileWithSignsPath'];
    contractStatusId = json['contractStatusId'];
    createdDate = json['createdDate'];
    if (json['transferContractFileDataModels'] != null) {
      transferContractFileDataModels = <TransferContractFileDataModels>[];
      json['transferContractFileDataModels'].forEach((v) {
        transferContractFileDataModels!
            .add(new TransferContractFileDataModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transfererId'] = this.transfererId;
    data['transfererName'] = this.transfererName;
    data['transfererPhoneNumber'] = this.transfererPhoneNumber;
    data['contractGroupId'] = this.contractGroupId;
    data['customerName'] = this.customerName;
    data['customerPhoneNumber'] = this.customerPhoneNumber;
    data['customerAddress'] = this.customerAddress;
    data['customerCitizenIdentificationInfoNumber'] =
        this.customerCitizenIdentificationInfoNumber;
    data['customerCitizenIdentificationInfoAddress'] =
        this.customerCitizenIdentificationInfoAddress;
    data['customerCitizenIdentificationInfoDateReceive'] =
        this.customerCitizenIdentificationInfoDateReceive;
    data['modelName'] = this.modelName;
    data['carLicensePlates'] = this.carLicensePlates;
    data['seatNumber'] = this.seatNumber;
    data['dateTransfer'] = this.dateTransfer;
    data['deliveryAddress'] = this.deliveryAddress;
    data['currentCarStateSpeedometerNumber'] =
        this.currentCarStateSpeedometerNumber;
    data['currentCarStateFuelPercent'] = this.currentCarStateFuelPercent;
    data['currentCarStateCurrentEtcAmount'] =
        this.currentCarStateCurrentEtcAmount;
    data['currentCarStateCarStatusDescription'] =
        this.currentCarStateCarStatusDescription;
    data['depositItemDownPayment'] = this.depositItemDownPayment;
    data['depositItemAsset'] = this.depositItemAsset;
    data['depositItemDescription'] = this.depositItemDescription;
    data['isExported'] = this.isExported;
    data['customerSignature'] = this.customerSignature;
    data['staffSignature'] = this.staffSignature;
    data['filePath'] = this.filePath;
    data['fileWithSignsPath'] = this.fileWithSignsPath;
    data['contractStatusId'] = this.contractStatusId;
    data['createdDate'] = this.createdDate;
    if (this.transferContractFileDataModels != null) {
      data['transferContractFileDataModels'] =
          this.transferContractFileDataModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Map<String, dynamic> toMap(TransferModel model) => <String, dynamic>{
        // 'auth_key': model.authKey,
        'id': model.id,
        'transfererId': model.transfererId,
        'transfererName': model.transfererName,
        'transfererPhoneNumber': model.transfererPhoneNumber,
        'contractGroupId': model.contractGroupId,
        'customerName': model.customerName,
        'customerPhoneNumber': model.customerPhoneNumber,
        'customerAddress': model.customerAddress,
        'customerCitizenIdentificationInfoNumber':
            model.customerCitizenIdentificationInfoNumber,
        'customerCitizenIdentificationInfoAddress':
            model.customerCitizenIdentificationInfoAddress,
        'customerCitizenIdentificationInfoDateReceive':
            model.customerCitizenIdentificationInfoDateReceive,
        'modelName': model.modelName,
        'carLicensePlates': model.carLicensePlates,
        'seatNumber': model.seatNumber,
        'dateTransfer': model.dateTransfer,
        'deliveryAddress': model.deliveryAddress,
        'currentCarStateSpeedometerNumber':
            model.currentCarStateSpeedometerNumber,
        'currentCarStateFuelPercent': model.currentCarStateFuelPercent,
        'currentCarStateCurrentEtcAmount':
            model.currentCarStateCurrentEtcAmount,
        'currentCarStateCarStatusDescription':
            model.currentCarStateCarStatusDescription,
        'depositItemDownPayment': model.depositItemDownPayment,
        'depositItemAsset': model.depositItemAsset,
        'depositItemDescription': model.depositItemDescription,
        'isExported': model.isExported,
        'customerSignature': model.customerSignature,
        'staffSignature': model.staffSignature,
        'filePath': model.filePath,
        'fileWithSignsPath': model.fileWithSignsPath,
        'contractStatusId': model.contractStatusId,
        'createdDate': model.createdDate,
        'transferContractFileCreateModels':
            model.transferContractFileDataModels,
      };

  static String serialize(TransferModel model) =>
      json.encode(TransferModel.toMap(model));

  static TransferModel deserialize(String json) =>
      TransferModel.fromJson(jsonDecode(json));
}
