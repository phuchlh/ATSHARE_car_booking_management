class Car {
  int? id;
  int? parkingLotId;
  String? parkingLotName;
  String? carStatus;
  String? carLicensePlates;
  int? seatNumber;
  int? carStatusId;
  int? carMakeId;
  int? carModelId;
  int? carGenerationId;
  int? carSeriesId;
  int? carTrimId;
  String? makeName;
  String? carDescription;
  String? modelName;
  String? generationName;
  String? seriesName;
  String? trimName;
  int? modelYear;
  int? generationYearBegin;
  int? generationYearEnd;
  int? trimStartProductYear;
  int? trimEndProductYear;
  String? createdDate;
  bool? isDeleted;
  String? carColor;
  String? carFuel;
  int? priceForNormalDay;
  int? priceForWeekendDay;
  int? priceForMonth;
  int? limitedKmForMonth;
  int? overLimitedMileage;
  String? carStatusDescription;
  int? currentEtcAmount;
  int? fuelPercent;
  int? speedometerNumber;
  String? carOwnerName;
  String? rentalMethod;
  String? rentalDate;
  int? speedometerNumberReceive;
  int? priceForDayReceive;
  int? priceForMonthReceive;
  bool? insurance;
  bool? maintenance;
  int? limitedKmForMonthReceive;
  int? overLimitedMileageReceive;
  String? filePath;
  String? frontImg;
  String? backImg;
  String? leftImg;
  String? rightImg;
  String? ortherImg;
  String? carFileCreatedDate;
  String? linkTracking;
  String? trackingUsername;
  String? trackingPassword;
  String? etcusername;
  String? etcpassword;
  String? linkForControl;
  String? paymentMethod;
  String? forControlDay;
  String? dayOfPayment;
  String? registrationDeadline;
  int? carKmLastMaintenance;
  int? ownerSlitRatio;
  int? periodicMaintenanceLimit;
  double? tankCapacity;
  Car({
    this.id,
    this.parkingLotId,
    this.carStatus,
    this.carStatusId,
    this.parkingLotName,
    this.carLicensePlates,
    this.seatNumber,
    this.carDescription,
    this.carMakeId,
    this.carModelId,
    this.carGenerationId,
    this.carSeriesId,
    this.carTrimId,
    this.makeName,
    this.modelName,
    this.modelYear,
    this.generationName,
    this.seriesName,
    this.trimName,
    this.generationYearBegin,
    this.generationYearEnd,
    this.trimStartProductYear,
    this.trimEndProductYear,
    this.createdDate,
    this.isDeleted,
    this.carColor,
    this.carFuel,
    this.priceForNormalDay,
    this.priceForWeekendDay,
    this.priceForMonth,
    this.limitedKmForMonth,
    this.overLimitedMileage,
    this.carStatusDescription,
    this.currentEtcAmount,
    this.fuelPercent,
    this.speedometerNumber,
    this.carOwnerName,
    this.rentalMethod,
    this.rentalDate,
    this.speedometerNumberReceive,
    this.priceForDayReceive,
    this.priceForMonthReceive,
    this.insurance,
    this.maintenance,
    this.limitedKmForMonthReceive,
    this.overLimitedMileageReceive,
    this.filePath,
    this.frontImg,
    this.backImg,
    this.leftImg,
    this.rightImg,
    this.ortherImg,
    this.carFileCreatedDate,
    this.linkTracking,
    this.trackingUsername,
    this.trackingPassword,
    this.etcusername,
    this.etcpassword,
    this.linkForControl,
    this.paymentMethod,
    this.forControlDay,
    this.registrationDeadline,
    this.carKmLastMaintenance,
    this.ownerSlitRatio,
    this.dayOfPayment,
    this.periodicMaintenanceLimit,
    this.tankCapacity,
  });

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carStatusId = json['carStatusId'];
    parkingLotId = json['parkingLotId'];
    parkingLotName = json['parkingLotName'];
    carStatus = json['carStatus'];
    carDescription = json['carDescription'];
    carLicensePlates = json['carLicensePlates'];
    seatNumber = json['seatNumber'];
    carMakeId = json['carMakeId'];
    carModelId = json['carModelId'];
    carGenerationId = json['carGenerationId'];
    carSeriesId = json['carSeriesId'];
    carTrimId = json['carTrimId'];
    modelYear = json['modelYear'];
    makeName = json['makeName'];
    modelName = json['modelName'];
    generationName = json['generationName'];
    seriesName = json['seriesName'];
    trimName = json['trimName'];
    generationYearBegin = json['generationYearBegin'];
    generationYearEnd = json['generationYearEnd'];
    trimStartProductYear = json['trimStartProductYear'];
    trimEndProductYear = json['trimEndProductYear'];
    createdDate = json['createdDate'];
    isDeleted = json['isDeleted'];
    carColor = json['carColor'];
    carFuel = json['carFuel'];
    priceForNormalDay = json['priceForNormalDay'];
    priceForWeekendDay = json['priceForWeekendDay'];
    priceForMonth = json['priceForMonth'];
    limitedKmForMonth = json['limitedKmForMonth'];
    overLimitedMileage = json['overLimitedMileage'];
    carStatusDescription = json['carStatusDescription'];
    currentEtcAmount = json['currentEtcAmount'];
    fuelPercent = json['fuelPercent'];
    speedometerNumber = json['speedometerNumber'];
    carOwnerName = json['carOwnerName'];
    rentalMethod = json['rentalMethod'];
    rentalDate = json['rentalDate'];
    speedometerNumberReceive = json['speedometerNumberReceive'];
    priceForDayReceive = json['priceForDayReceive'];
    priceForMonthReceive = json['priceForMonthReceive'];
    insurance = json['insurance'];
    maintenance = json['maintenance'];
    limitedKmForMonthReceive = json['limitedKmForMonthReceive'];
    overLimitedMileageReceive = json['overLimitedMileageReceive'];
    filePath = json['filePath'];
    frontImg = json['frontImg'];
    backImg = json['backImg'];
    leftImg = json['leftImg'];
    rightImg = json['rightImg'];
    ortherImg = json['ortherImg'];
    carFileCreatedDate = json['carFileCreatedDate'];
    linkTracking = json['linkTracking'];
    trackingUsername = json['trackingUsername'];
    trackingPassword = json['trackingPassword'];
    etcusername = json['etcusername'];
    etcpassword = json['etcpassword'];
    linkForControl = json['linkForControl'];
    paymentMethod = json['paymentMethod'];
    forControlDay = json['forControlDay'];
    dayOfPayment = json['dayOfPayment'];
    registrationDeadline = json['registrationDeadline'];
    carKmLastMaintenance = json['carKmLastMaintenance'];
    ownerSlitRatio = json['ownerSlitRatio'];
    periodicMaintenanceLimit = json['periodicMaintenanceLimit'];
    maintenance = json['maintenance'];
    tankCapacity = json['tankCapacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carStatusId'] = this.carStatusId;
    data['parkingLotId'] = this.parkingLotId;
    data['parkingLotName'] = this.parkingLotName;
    data['carStatus'] = this.carStatus;
    data['carLicensePlates'] = this.carLicensePlates;
    data['seatNumber'] = this.seatNumber;
    data['carMakeId'] = this.carMakeId;
    data['carModelId'] = this.carModelId;
    data['modelYear'] = this.modelYear;
    data['carGenerationId'] = this.carGenerationId;
    data['carSeriesId'] = this.carSeriesId;
    data['carTrimId'] = this.carTrimId;
    data['carDescription'] = this.carDescription;
    data['makeName'] = this.makeName;
    data['modelName'] = this.modelName;
    data['generationName'] = this.generationName;
    data['seriesName'] = this.seriesName;
    data['trimName'] = this.trimName;
    data['generationYearBegin'] = this.generationYearBegin;
    data['generationYearEnd'] = this.generationYearEnd;
    data['trimStartProductYear'] = this.trimStartProductYear;
    data['trimEndProductYear'] = this.trimEndProductYear;
    data['createdDate'] = this.createdDate;
    data['isDeleted'] = this.isDeleted;
    data['carColor'] = this.carColor;
    data['carFuel'] = this.carFuel;
    data['priceForNormalDay'] = this.priceForNormalDay;
    data['priceForWeekendDay'] = this.priceForWeekendDay;
    data['priceForMonth'] = this.priceForMonth;
    data['limitedKmForMonth'] = this.limitedKmForMonth;
    data['overLimitedMileage'] = this.overLimitedMileage;
    data['carStatusDescription'] = this.carStatusDescription;
    data['currentEtcAmount'] = this.currentEtcAmount;
    data['fuelPercent'] = this.fuelPercent;
    data['speedometerNumber'] = this.speedometerNumber;
    data['carOwnerName'] = this.carOwnerName;
    data['rentalMethod'] = this.rentalMethod;
    data['rentalDate'] = this.rentalDate;
    data['speedometerNumberReceive'] = this.speedometerNumberReceive;
    data['priceForDayReceive'] = this.priceForDayReceive;
    data['priceForMonthReceive'] = this.priceForMonthReceive;
    data['insurance'] = this.insurance;
    data['maintenance'] = this.maintenance;
    data['limitedKmForMonthReceive'] = this.limitedKmForMonthReceive;
    data['overLimitedMileageReceive'] = this.overLimitedMileageReceive;
    data['filePath'] = this.filePath;
    data['frontImg'] = this.frontImg;
    data['backImg'] = this.backImg;
    data['leftImg'] = this.leftImg;
    data['rightImg'] = this.rightImg;
    data['ortherImg'] = this.ortherImg;
    data['carFileCreatedDate'] = this.carFileCreatedDate;
    data['linkTracking'] = this.linkTracking;
    data['trackingUsername'] = this.trackingUsername;
    data['trackingPassword'] = this.trackingPassword;
    data['etcusername'] = this.etcusername;
    data['etcpassword'] = this.etcpassword;
    data['linkForControl'] = this.linkForControl;
    data['paymentMethod'] = this.paymentMethod;
    data['forControlDay'] = this.forControlDay;
    data['dayOfPayment'] = this.dayOfPayment;
    data['registrationDeadline'] = this.registrationDeadline;
    data['carKmLastMaintenance'] = this.carKmLastMaintenance;
    data['ownerSlitRatio'] = this.ownerSlitRatio;
    data['periodicMaintenanceLimit'] = this.periodicMaintenanceLimit;
    data['maintenance'] = this.maintenance;
    data['tankCapacity'] = this.tankCapacity;
    return data;
  }
}
