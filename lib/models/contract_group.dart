class ContractGroup {
  int? id;
  int? customerInfoId;
  int? userId;
  String? staffEmail;
  int? carId;
  String? rentPurpose;
  String? rentFrom;
  String? rentTo;
  String? requireDescriptionInfoCarBrand;
  int? requireDescriptionInfoSeatNumber;
  int? requireDescriptionInfoPriceForDay;
  String? requireDescriptionInfoCarColor;
  String? requireDescriptionInfoGearBox;
  String? deliveryAddress;
  int? contractGroupStatusId;
  String? contractGroupStatusName;
  String? customerName;
  String? phoneNumber;
  String? customerAddress;
  String? citizenIdentificationInfoNumber;
  String? citizenIdentificationInfoAddress;
  String? citizenIdentificationInfoDateReceive;
  String? customerSocialInfoZalo;
  String? customerSocialInfoFacebook;
  String? relativeTel;
  String? companyInfo;
  String? customerEmail;
  List<CustomerFiles>? customerFiles;

  ContractGroup(
      {this.id,
      this.customerInfoId,
      this.userId,
      this.staffEmail,
      this.carId,
      this.rentPurpose,
      this.rentFrom,
      this.rentTo,
      this.requireDescriptionInfoCarBrand,
      this.requireDescriptionInfoSeatNumber,
      this.requireDescriptionInfoPriceForDay,
      this.requireDescriptionInfoCarColor,
      this.requireDescriptionInfoGearBox,
      this.deliveryAddress,
      this.contractGroupStatusId,
      this.contractGroupStatusName,
      this.customerName,
      this.phoneNumber,
      this.customerAddress,
      this.citizenIdentificationInfoNumber,
      this.citizenIdentificationInfoAddress,
      this.citizenIdentificationInfoDateReceive,
      this.customerSocialInfoZalo,
      this.customerSocialInfoFacebook,
      this.relativeTel,
      this.companyInfo,
      this.customerEmail,
      this.customerFiles});

  ContractGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerInfoId = json['customerInfoId'];
    userId = json['userId'];
    staffEmail = json['staffEmail'];
    carId = json['carId'];
    rentPurpose = json['rentPurpose'];
    rentFrom = json['rentFrom'];
    rentTo = json['rentTo'];
    requireDescriptionInfoCarBrand = json['requireDescriptionInfoCarBrand'];
    requireDescriptionInfoSeatNumber = json['requireDescriptionInfoSeatNumber'];
    requireDescriptionInfoPriceForDay = json['requireDescriptionInfoPriceForDay'];
    requireDescriptionInfoCarColor = json['requireDescriptionInfoCarColor'];
    requireDescriptionInfoGearBox = json['requireDescriptionInfoGearBox'];
    deliveryAddress = json['deliveryAddress'];
    contractGroupStatusId = json['contractGroupStatusId'];
    contractGroupStatusName = json['contractGroupStatusName'];
    customerName = json['customerName'];
    phoneNumber = json['phoneNumber'];
    customerAddress = json['customerAddress'];
    citizenIdentificationInfoNumber = json['citizenIdentificationInfoNumber'];
    citizenIdentificationInfoAddress = json['citizenIdentificationInfoAddress'];
    citizenIdentificationInfoDateReceive = json['citizenIdentificationInfoDateReceive'];
    customerSocialInfoZalo = json['customerSocialInfoZalo'];
    customerSocialInfoFacebook = json['customerSocialInfoFacebook'];
    relativeTel = json['relativeTel'];
    companyInfo = json['companyInfo'];
    customerEmail = json['customerEmail'];
    if (json['customerFiles'] != null) {
      customerFiles = <CustomerFiles>[];
      json['customerFiles'].forEach((v) {
        customerFiles!.add(new CustomerFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerInfoId'] = this.customerInfoId;
    data['userId'] = this.userId;
    data['staffEmail'] = this.staffEmail;
    data['carId'] = this.carId;
    data['rentPurpose'] = this.rentPurpose;
    data['rentFrom'] = this.rentFrom;
    data['rentTo'] = this.rentTo;
    data['requireDescriptionInfoCarBrand'] = this.requireDescriptionInfoCarBrand;
    data['requireDescriptionInfoSeatNumber'] = this.requireDescriptionInfoSeatNumber;
    data['requireDescriptionInfoPriceForDay'] = this.requireDescriptionInfoPriceForDay;
    data['requireDescriptionInfoCarColor'] = this.requireDescriptionInfoCarColor;
    data['requireDescriptionInfoGearBox'] = this.requireDescriptionInfoGearBox;
    data['deliveryAddress'] = this.deliveryAddress;
    data['contractGroupStatusId'] = this.contractGroupStatusId;
    data['contractGroupStatusName'] = this.contractGroupStatusName;
    data['customerName'] = this.customerName;
    data['phoneNumber'] = this.phoneNumber;
    data['customerAddress'] = this.customerAddress;
    data['citizenIdentificationInfoNumber'] = this.citizenIdentificationInfoNumber;
    data['citizenIdentificationInfoAddress'] = this.citizenIdentificationInfoAddress;
    data['citizenIdentificationInfoDateReceive'] = this.citizenIdentificationInfoDateReceive;
    data['customerSocialInfoZalo'] = this.customerSocialInfoZalo;
    data['customerSocialInfoFacebook'] = this.customerSocialInfoFacebook;
    data['relativeTel'] = this.relativeTel;
    data['companyInfo'] = this.companyInfo;
    data['customerEmail'] = this.customerEmail;
    if (this.customerFiles != null) {
      data['customerFiles'] = this.customerFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerFiles {
  int? id;
  int? customerInfoId;
  String? typeOfDocument;
  String? title;
  String? documentImg;
  String? documentDescription;

  CustomerFiles(
      {this.id,
      this.customerInfoId,
      this.typeOfDocument,
      this.title,
      this.documentImg,
      this.documentDescription});

  CustomerFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerInfoId = json['customerInfoId'];
    typeOfDocument = json['typeOfDocument'];
    title = json['title'];
    documentImg = json['documentImg'];
    documentDescription = json['documentDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerInfoId'] = this.customerInfoId;
    data['typeOfDocument'] = this.typeOfDocument;
    data['title'] = this.title;
    data['documentImg'] = this.documentImg;
    data['documentDescription'] = this.documentDescription;
    return data;
  }
}
