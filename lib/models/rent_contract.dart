class RentContract {
  int? id;
  int? contractGroupId;
  int? representativeId;
  String? representativeName;
  String? representativePhoneNumber;
  String? representativeAddress;
  String? customerCitizenIdentificationInfoNumber;
  String? customerCitizenIdentificationInfoAddress;
  String? customerCitizenIdentificationInfoDateReceive;
  String? customerAddress;
  String? customerPhoneNumber;
  String? carModel;
  String? carLicensePlates;
  int? seatNumber;
  String? rentFrom;
  String? rentTo;
  String? deliveryAddress;
  int? carGeneralInfoAtRentPriceForNormalDay;
  int? carGeneralInfoAtRentPriceForWeekendDay;
  int? carGeneralInfoAtRentPricePerKmExceed;
  int? carGeneralInfoAtRentPricePerHourExceed;
  int? carGeneralInfoAtRentLimitedKmForMonth;
  int? carGeneralInfoAtRentPriceForMonth;
  int? deliveryFee;
  String? createdDate;
  int? paymentAmount;
  int? depositInfoCarRental;
  String? depositItemDescription;
  int? depositItemDownPayment;
  String? customerSignature;
  String? staffSignature;
  String? filePath;
  String? fileWithSignsPath;
  bool? isExported;
  String? cancelReason;
  int? contractStatusId;

  RentContract(
      {this.id,
      this.contractGroupId,
      this.representativeId,
      this.representativeName,
      this.representativePhoneNumber,
      this.representativeAddress,
      this.customerCitizenIdentificationInfoNumber,
      this.customerCitizenIdentificationInfoAddress,
      this.customerCitizenIdentificationInfoDateReceive,
      this.customerAddress,
      this.customerPhoneNumber,
      this.carModel,
      this.carLicensePlates,
      this.seatNumber,
      this.rentFrom,
      this.rentTo,
      this.deliveryAddress,
      this.carGeneralInfoAtRentPriceForNormalDay,
      this.carGeneralInfoAtRentPriceForWeekendDay,
      this.carGeneralInfoAtRentPricePerKmExceed,
      this.carGeneralInfoAtRentPricePerHourExceed,
      this.carGeneralInfoAtRentLimitedKmForMonth,
      this.carGeneralInfoAtRentPriceForMonth,
      this.deliveryFee,
      this.createdDate,
      this.paymentAmount,
      this.depositInfoCarRental,
      this.depositItemDescription,
      this.depositItemDownPayment,
      this.customerSignature,
      this.staffSignature,
      this.filePath,
      this.fileWithSignsPath,
      this.isExported,
      this.cancelReason,
      this.contractStatusId});

  RentContract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractGroupId = json['contractGroupId'];
    representativeId = json['representativeId'];
    representativeName = json['representativeName'];
    representativePhoneNumber = json['representativePhoneNumber'];
    representativeAddress = json['representativeAddress'];
    customerCitizenIdentificationInfoNumber =
        json['customerCitizenIdentificationInfoNumber'];
    customerCitizenIdentificationInfoAddress =
        json['customerCitizenIdentificationInfoAddress'];
    customerCitizenIdentificationInfoDateReceive =
        json['customerCitizenIdentificationInfoDateReceive'];
    customerAddress = json['customerAddress'];
    customerPhoneNumber = json['customerPhoneNumber'];
    carModel = json['carModel'];
    carLicensePlates = json['carLicensePlates'];
    seatNumber = json['seatNumber'];
    rentFrom = json['rentFrom'];
    rentTo = json['rentTo'];
    deliveryAddress = json['deliveryAddress'];
    carGeneralInfoAtRentPriceForNormalDay =
        json['carGeneralInfoAtRentPriceForNormalDay'];
    carGeneralInfoAtRentPriceForWeekendDay =
        json['carGeneralInfoAtRentPriceForWeekendDay'];
    carGeneralInfoAtRentPricePerKmExceed =
        json['carGeneralInfoAtRentPricePerKmExceed'];
    carGeneralInfoAtRentPricePerHourExceed =
        json['carGeneralInfoAtRentPricePerHourExceed'];
    carGeneralInfoAtRentLimitedKmForMonth =
        json['carGeneralInfoAtRentLimitedKmForMonth'];
    carGeneralInfoAtRentPriceForMonth =
        json['carGeneralInfoAtRentPriceForMonth'];
    deliveryFee = json['deliveryFee'];
    createdDate = json['createdDate'];
    paymentAmount = json['paymentAmount'];
    depositInfoCarRental = json['depositInfoCarRental'];
    depositItemDescription = json['depositItemDescription'];
    depositItemDownPayment = json['depositItemDownPayment'];
    customerSignature = json['customerSignature'];
    staffSignature = json['staffSignature'];
    filePath = json['filePath'];
    fileWithSignsPath = json['fileWithSignsPath'];
    isExported = json['isExported'];
    cancelReason = json['cancelReason'];
    contractStatusId = json['contractStatusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contractGroupId'] = this.contractGroupId;
    data['representativeId'] = this.representativeId;
    data['representativeName'] = this.representativeName;
    data['representativePhoneNumber'] = this.representativePhoneNumber;
    data['representativeAddress'] = this.representativeAddress;
    data['customerCitizenIdentificationInfoNumber'] =
        this.customerCitizenIdentificationInfoNumber;
    data['customerCitizenIdentificationInfoAddress'] =
        this.customerCitizenIdentificationInfoAddress;
    data['customerCitizenIdentificationInfoDateReceive'] =
        this.customerCitizenIdentificationInfoDateReceive;
    data['customerAddress'] = this.customerAddress;
    data['customerPhoneNumber'] = this.customerPhoneNumber;
    data['carModel'] = this.carModel;
    data['carLicensePlates'] = this.carLicensePlates;
    data['seatNumber'] = this.seatNumber;
    data['rentFrom'] = this.rentFrom;
    data['rentTo'] = this.rentTo;
    data['deliveryAddress'] = this.deliveryAddress;
    data['carGeneralInfoAtRentPriceForNormalDay'] =
        this.carGeneralInfoAtRentPriceForNormalDay;
    data['carGeneralInfoAtRentPriceForWeekendDay'] =
        this.carGeneralInfoAtRentPriceForWeekendDay;
    data['carGeneralInfoAtRentPricePerKmExceed'] =
        this.carGeneralInfoAtRentPricePerKmExceed;
    data['carGeneralInfoAtRentPricePerHourExceed'] =
        this.carGeneralInfoAtRentPricePerHourExceed;
    data['carGeneralInfoAtRentLimitedKmForMonth'] =
        this.carGeneralInfoAtRentLimitedKmForMonth;
    data['carGeneralInfoAtRentPriceForMonth'] =
        this.carGeneralInfoAtRentPriceForMonth;
    data['deliveryFee'] = this.deliveryFee;
    data['createdDate'] = this.createdDate;
    data['paymentAmount'] = this.paymentAmount;
    data['depositInfoCarRental'] = this.depositInfoCarRental;
    data['depositItemDescription'] = this.depositItemDescription;
    data['depositItemDownPayment'] = this.depositItemDownPayment;
    data['customerSignature'] = this.customerSignature;
    data['staffSignature'] = this.staffSignature;
    data['filePath'] = this.filePath;
    data['fileWithSignsPath'] = this.fileWithSignsPath;
    data['isExported'] = this.isExported;
    data['cancelReason'] = this.cancelReason;
    data['contractStatusId'] = this.contractStatusId;
    return data;
  }
}
