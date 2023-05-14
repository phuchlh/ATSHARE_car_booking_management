import 'package:booking_car/models/receive_model.dart';

class ReceivePut {
  int? id;
  int? receiverId;
  int? contractGroupId;
  int? transferContractId;
  String? dateReceive;
  String? receiveAddress;
  bool? originalCondition;
  int? currentCarStateSpeedometerNumber;
  int? currentCarStateFuelPercent;
  int? currentCarStateCurrentEtcAmount;
  String? currentCarStateCarStatusDescription;
  String? depositItemAsset;
  String? depositItemDescription;
  int? depositItemDownPayment;
  bool? returnDepostiItem;
  String? staffSignature;
  String? customerSignature;
  int? contractStatusId;
  int? totalKilometersTraveled;
  String? currentCarStateCarDamageDescription;
  int? insuranceMoney;
  int? extraTime;
  bool? detectedViolations;
  String? speedingViolationDescription;
  String? forbiddenRoadViolationDescription;
  String? trafficLightViolationDescription;
  String? ortherViolation;
  int? violationMoney;
  int? currentFuelMoney;
  int? totalPayment;
  List<ReceiveContractFileDataModels>? receiveContractFileDataModels;

  ReceivePut({
    this.id,
    this.receiverId,
    this.contractGroupId,
    this.transferContractId,
    this.dateReceive,
    this.receiveAddress,
    this.originalCondition,
    this.currentCarStateSpeedometerNumber,
    this.currentCarStateFuelPercent,
    this.currentCarStateCurrentEtcAmount,
    this.currentCarStateCarStatusDescription,
    this.depositItemAsset,
    this.depositItemDescription,
    this.depositItemDownPayment,
    this.returnDepostiItem,
    this.staffSignature,
    this.customerSignature,
    this.contractStatusId,
    this.totalKilometersTraveled,
    this.currentCarStateCarDamageDescription,
    this.insuranceMoney,
    this.extraTime,
    this.detectedViolations,
    this.speedingViolationDescription,
    this.forbiddenRoadViolationDescription,
    this.trafficLightViolationDescription,
    this.ortherViolation,
    this.violationMoney,
    this.currentFuelMoney,
    this.totalPayment,
    this.receiveContractFileDataModels,
  });

  ReceivePut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiverId = json['receiverId'];
    contractGroupId = json['contractGroupId'];
    transferContractId = json['transferContractId'];
    dateReceive = json['dateReceive'];
    receiveAddress = json['receiveAddress'];
    originalCondition = json['originalCondition'];
    currentCarStateSpeedometerNumber = json['currentCarStateSpeedometerNumber'];
    currentCarStateFuelPercent = json['currentCarStateFuelPercent'];
    currentCarStateCurrentEtcAmount = json['currentCarStateCurrentEtcAmount'];
    currentCarStateCarStatusDescription = json['currentCarStateCarStatusDescription'];
    depositItemAsset = json['depositItemAsset'];
    depositItemDescription = json['depositItemDescription'];
    depositItemDownPayment = json['depositItemDownPayment'];
    returnDepostiItem = json['returnDepostiItem'];
    staffSignature = json['staffSignature'];
    customerSignature = json['customerSignature'];
    contractStatusId = json['contractStatusId'];
    totalKilometersTraveled = json['totalKilometersTraveled'];
    currentCarStateCarDamageDescription = json['currentCarStateCarDamageDescription'];
    insuranceMoney = json['insuranceMoney'];
    extraTime = json['extraTime'];
    detectedViolations = json['detectedViolations'];
    speedingViolationDescription = json['speedingViolationDescription'];
    forbiddenRoadViolationDescription = json['forbiddenRoadViolationDescription'];
    trafficLightViolationDescription = json['trafficLightViolationDescription'];
    ortherViolation = json['ortherViolation'];
    violationMoney = json['violationMoney'];
    currentFuelMoney = json['currentFuelMoney'];
    totalPayment = json['totalPayment'];
    if (json['receiveContractFileDataModels'] != null) {
      receiveContractFileDataModels = <ReceiveContractFileDataModels>[];
      json['receiveContractFileDataModels'].forEach((v) {
        receiveContractFileDataModels!.add(new ReceiveContractFileDataModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiverId'] = this.receiverId;
    data['contractGroupId'] = this.contractGroupId;
    data['transferContractId'] = this.transferContractId;
    data['dateReceive'] = this.dateReceive;
    data['receiveAddress'] = this.receiveAddress;
    data['originalCondition'] = this.originalCondition;
    data['currentCarStateSpeedometerNumber'] = this.currentCarStateSpeedometerNumber;
    data['currentCarStateFuelPercent'] = this.currentCarStateFuelPercent;
    data['currentCarStateCurrentEtcAmount'] = this.currentCarStateCurrentEtcAmount;
    data['currentCarStateCarStatusDescription'] = this.currentCarStateCarStatusDescription;
    data['depositItemAsset'] = this.depositItemAsset;
    data['depositItemDescription'] = this.depositItemDescription;
    data['depositItemDownPayment'] = this.depositItemDownPayment;
    data['returnDepostiItem'] = this.returnDepostiItem;
    data['staffSignature'] = this.staffSignature;
    data['customerSignature'] = this.customerSignature;
    data['contractStatusId'] = this.contractStatusId;
    data['totalKilometersTraveled'] = this.totalKilometersTraveled;
    data['currentCarStateCarDamageDescription'] = this.currentCarStateCarDamageDescription;
    data['insuranceMoney'] = this.insuranceMoney;
    data['extraTime'] = this.extraTime;
    data['detectedViolations'] = this.detectedViolations;
    data['speedingViolationDescription'] = this.speedingViolationDescription;
    data['forbiddenRoadViolationDescription'] = this.forbiddenRoadViolationDescription;
    data['trafficLightViolationDescription'] = this.trafficLightViolationDescription;
    data['ortherViolation'] = this.ortherViolation;
    data['violationMoney'] = this.violationMoney;
    data['currentFuelMoney'] = this.currentFuelMoney;
    data['totalPayment'] = this.totalPayment;
    if (this.receiveContractFileDataModels != null) {
      data['receiveContractFileDataModels'] =
          this.receiveContractFileDataModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory ReceivePut.fromReceiveModel(ReceiveModel model) {
    return ReceivePut(
      id: model.id,
      receiverId: model.receiverId,
      contractGroupId: model.contractGroupId,
      transferContractId: model.transferContractId,
      dateReceive: model.dateReceive,
      receiveAddress: model.receiveAddress,
      originalCondition: model.originalCondition,
      currentCarStateSpeedometerNumber: model.currentCarStateSpeedometerNumber,
      currentCarStateFuelPercent: model.currentCarStateFuelPercent,
      currentCarStateCurrentEtcAmount: model.currentCarStateCurrentEtcAmount,
      currentCarStateCarStatusDescription: model.currentCarStateCarStatusDescription,
      depositItemAsset: model.depositItemAsset,
      depositItemDescription: model.depositItemDescription,
      depositItemDownPayment: model.depositItemDownPayment,
      returnDepostiItem: model.returnDepostiItem,
      staffSignature: model.staffSignature,
      customerSignature: model.customerSignature,
      contractStatusId: model.contractStatusId,
      totalKilometersTraveled: model.totalKilometersTraveled,
      currentCarStateCarDamageDescription: model.currentCarStateCarDamageDescription,
      insuranceMoney: model.insuranceMoney,
      extraTime: model.extraTime,
      detectedViolations: model.detectedViolations,
      speedingViolationDescription: model.speedingViolationDescription,
      forbiddenRoadViolationDescription: model.forbiddenRoadViolationDescription,
      trafficLightViolationDescription: model.trafficLightViolationDescription,
      ortherViolation: model.ortherViolation,
      violationMoney: model.violationMoney,
      currentFuelMoney: model.currentFuelMoney,
      totalPayment: model.totalPayment,
      receiveContractFileDataModels: model.receiveContractFileDataModels,
    );
  }
}
