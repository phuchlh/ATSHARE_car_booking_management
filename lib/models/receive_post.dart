class ReceivePost {
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
  int? depositItemDownPayment;
  bool? returnDepostiItem;
  String? createdDate;
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
  List<ReceiveContractFileCreateModels>? receiveContractFileCreateModels;

  ReceivePost({
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
    this.depositItemDownPayment,
    this.returnDepostiItem,
    this.createdDate,
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
    this.receiveContractFileCreateModels,
  });

  ReceivePost.fromJson(Map<String, dynamic> json) {
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
    depositItemDownPayment = json['depositItemDownPayment'];
    returnDepostiItem = json['returnDepostiItem'];
    createdDate = json['createdDate'];
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
    if (json['receiveContractFileCreateModels'] != null) {
      receiveContractFileCreateModels = <ReceiveContractFileCreateModels>[];
      json['receiveContractFileCreateModels'].forEach((v) {
        receiveContractFileCreateModels!.add(new ReceiveContractFileCreateModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['depositItemDownPayment'] = this.depositItemDownPayment;
    data['returnDepostiItem'] = this.returnDepostiItem;
    data['createdDate'] = this.createdDate;
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
    if (this.receiveContractFileCreateModels != null) {
      data['receiveContractFileCreateModels'] =
          this.receiveContractFileCreateModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceiveContractFileCreateModels {
  String? title;
  String? documentImg;
  String? documentDescription;

  ReceiveContractFileCreateModels({this.title, this.documentImg, this.documentDescription});

  ReceiveContractFileCreateModels.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    documentImg = json['documentImg'];
    documentDescription = json['documentDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['documentImg'] = this.documentImg;
    data['documentDescription'] = this.documentDescription;
    return data;
  }
}
