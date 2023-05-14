class ReceiveModel {
  int? id;
  int? receiverId;
  String? receiverName;
  String? receiverPhoneNumber;
  int? contractGroupId;
  String? customerName;
  String? customerPhoneNumber;
  String? customerAddress;
  String? customerCitizenIdentificationInfoNumber;
  String? customerCitizenIdentificationInfoDateReceive;
  String? customerCitizenIdentificationInfoAddress;
  int? transferContractId;
  String? dateReceive;
  String? receiveAddress;
  int? currentCarStateSpeedometerNumber;
  int? currentCarStateFuelPercent;
  int? currentCarStateCurrentEtcAmount;
  String? currentCarStateCarStatusDescription;
  bool? originalCondition;
  String? depositItemAsset;
  String? depositItemDescription;
  int? depositItemDownPayment;
  bool? returnDepostiItem;
  String? createdDate;
  String? filePath;
  String? staffSignature;
  String? customerSignature;
  String? fileWithSignsPath;
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
  List<ReceiveContractFileDataModels>? receiveContractFileDataModels;
  int? currentFuelMoney;
  int? totalPayment;

  ReceiveModel({
    this.id,
    this.receiverId,
    this.receiverName,
    this.receiverPhoneNumber,
    this.contractGroupId,
    this.customerName,
    this.customerPhoneNumber,
    this.customerAddress,
    this.customerCitizenIdentificationInfoNumber,
    this.customerCitizenIdentificationInfoDateReceive,
    this.customerCitizenIdentificationInfoAddress,
    this.transferContractId,
    this.dateReceive,
    this.receiveAddress,
    this.currentCarStateSpeedometerNumber,
    this.currentCarStateFuelPercent,
    this.currentCarStateCurrentEtcAmount,
    this.currentCarStateCarStatusDescription,
    this.originalCondition,
    this.depositItemAsset,
    this.depositItemDescription,
    this.depositItemDownPayment,
    this.returnDepostiItem,
    this.createdDate,
    this.filePath,
    this.staffSignature,
    this.customerSignature,
    this.fileWithSignsPath,
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
    this.receiveContractFileDataModels,
    this.currentFuelMoney,
    this.totalPayment,
  });

  ReceiveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    receiverPhoneNumber = json['receiverPhoneNumber'];
    contractGroupId = json['contractGroupId'];
    customerName = json['customerName'];
    customerPhoneNumber = json['customerPhoneNumber'];
    customerAddress = json['customerAddress'];
    customerCitizenIdentificationInfoNumber = json['customerCitizenIdentificationInfoNumber'];
    customerCitizenIdentificationInfoDateReceive =
        json['customerCitizenIdentificationInfoDateReceive'];
    customerCitizenIdentificationInfoAddress = json['customerCitizenIdentificationInfoAddress'];
    transferContractId = json['transferContractId'];
    dateReceive = json['dateReceive'];
    receiveAddress = json['receiveAddress'];
    currentCarStateSpeedometerNumber = json['currentCarStateSpeedometerNumber'];
    currentCarStateFuelPercent = json['currentCarStateFuelPercent'];
    currentCarStateCurrentEtcAmount = json['currentCarStateCurrentEtcAmount'];
    currentCarStateCarStatusDescription = json['currentCarStateCarStatusDescription'];
    originalCondition = json['originalCondition'];
    depositItemAsset = json['depositItemAsset'];
    depositItemDescription = json['depositItemDescription'];
    depositItemDownPayment = json['depositItemDownPayment'];
    returnDepostiItem = json['returnDepostiItem'];
    createdDate = json['createdDate'];
    filePath = json['filePath'];
    staffSignature = json['staffSignature'];
    customerSignature = json['customerSignature'];
    fileWithSignsPath = json['fileWithSignsPath'];
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
    totalPayment = json['totalPayment'];
    currentFuelMoney = json['currentFuelMoney'];
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
    data['receiverName'] = this.receiverName;
    data['receiverPhoneNumber'] = this.receiverPhoneNumber;
    data['contractGroupId'] = this.contractGroupId;
    data['customerName'] = this.customerName;
    data['customerPhoneNumber'] = this.customerPhoneNumber;
    data['customerAddress'] = this.customerAddress;
    data['customerCitizenIdentificationInfoNumber'] = this.customerCitizenIdentificationInfoNumber;
    data['customerCitizenIdentificationInfoDateReceive'] =
        this.customerCitizenIdentificationInfoDateReceive;
    data['customerCitizenIdentificationInfoAddress'] =
        this.customerCitizenIdentificationInfoAddress;
    data['transferContractId'] = this.transferContractId;
    data['dateReceive'] = this.dateReceive;
    data['receiveAddress'] = this.receiveAddress;
    data['currentCarStateSpeedometerNumber'] = this.currentCarStateSpeedometerNumber;
    data['currentCarStateFuelPercent'] = this.currentCarStateFuelPercent;
    data['currentCarStateCurrentEtcAmount'] = this.currentCarStateCurrentEtcAmount;
    data['currentCarStateCarStatusDescription'] = this.currentCarStateCarStatusDescription;
    data['originalCondition'] = this.originalCondition;
    data['depositItemAsset'] = this.depositItemAsset;
    data['depositItemDescription'] = this.depositItemDescription;
    data['depositItemDownPayment'] = this.depositItemDownPayment;
    data['returnDepostiItem'] = this.returnDepostiItem;
    data['createdDate'] = this.createdDate;
    data['filePath'] = this.filePath;
    data['staffSignature'] = this.staffSignature;
    data['customerSignature'] = this.customerSignature;
    data['fileWithSignsPath'] = this.fileWithSignsPath;
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
}

class ReceiveContractFileDataModels {
  int? id;
  int? receiveContractId;
  String? title;
  String? documentImg;
  String? documentDescription;

  ReceiveContractFileDataModels(
      {this.id, this.receiveContractId, this.title, this.documentImg, this.documentDescription});

  ReceiveContractFileDataModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiveContractId = json['receiveContractId'];
    title = json['title'];
    documentImg = json['documentImg'];
    documentDescription = json['documentDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiveContractId'] = this.receiveContractId;
    data['title'] = this.title;
    data['documentImg'] = this.documentImg;
    data['documentDescription'] = this.documentDescription;
    return data;
  }
}
