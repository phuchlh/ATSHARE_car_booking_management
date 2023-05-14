class User {
  int? id;
  int? parkingLotId;
  String? name;
  String? phoneNumber;
  String? job;
  String? currentAddress;
  String? email;
  String? password;
  String? cardImage;
  String? passwordHash;
  String? passwordSalt;
  String? role;
  String? citizenIdentificationInfoNumber;
  String? citizenIdentificationInfoAddress;
  String? citizenIdentificationInfoDateReceive;
  String? passportInfoNumber;
  String? passportInfoAddress;
  String? passportInfoDateReceive;
  String? createdDate;
  bool? isDeleted;
  String? parkingLot;
  List<Null>? appraisalRecords;
  List<Null>? contractGroups;
  List<Null>? receiveContracts;
  List<Null>? rentContracts;
  List<Null>? transferContracts;

  User(
      {this.id,
      this.parkingLotId,
      this.name,
      this.phoneNumber,
      this.job,
      this.currentAddress,
      this.email,
      this.password,
      this.cardImage,
      this.passwordHash,
      this.passwordSalt,
      this.role,
      this.citizenIdentificationInfoNumber,
      this.citizenIdentificationInfoAddress,
      this.citizenIdentificationInfoDateReceive,
      this.passportInfoNumber,
      this.passportInfoAddress,
      this.passportInfoDateReceive,
      this.createdDate,
      this.isDeleted,
      this.parkingLot,
      this.appraisalRecords,
      this.contractGroups,
      this.receiveContracts,
      this.rentContracts,
      this.transferContracts});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parkingLotId = json['parkingLotId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    job = json['job'];
    currentAddress = json['currentAddress'];
    email = json['email'];
    password = json['password'];
    cardImage = json['cardImage'];
    passwordHash = json['passwordHash'];
    passwordSalt = json['passwordSalt'];
    role = json['role'];
    citizenIdentificationInfoNumber = json['citizenIdentificationInfoNumber'];
    citizenIdentificationInfoAddress = json['citizenIdentificationInfoAddress'];
    citizenIdentificationInfoDateReceive =
        json['citizenIdentificationInfoDateReceive'];
    passportInfoNumber = json['passportInfoNumber'];
    passportInfoAddress = json['passportInfoAddress'];
    passportInfoDateReceive = json['passportInfoDateReceive'];
    createdDate = json['createdDate'];
    isDeleted = json['isDeleted'];
    parkingLot = json['parkingLot'];
    // if (json['appraisalRecords'] != null) {
    //   appraisalRecords = <Null>[];
    //   json['appraisalRecords'].forEach((v) {
    //     appraisalRecords!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['contractGroups'] != null) {
    //   contractGroups = <Null>[];
    //   json['contractGroups'].forEach((v) {
    //     contractGroups!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['receiveContracts'] != null) {
    //   receiveContracts = <Null>[];
    //   json['receiveContracts'].forEach((v) {
    //     receiveContracts!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['rentContracts'] != null) {
    //   rentContracts = <Null>[];
    //   json['rentContracts'].forEach((v) {
    //     rentContracts!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['transferContracts'] != null) {
    //   transferContracts = <Null>[];
    //   json['transferContracts'].forEach((v) {
    //     transferContracts!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parkingLotId'] = this.parkingLotId;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['job'] = this.job;
    data['currentAddress'] = this.currentAddress;
    data['email'] = this.email;
    data['password'] = this.password;
    data['cardImage'] = this.cardImage;
    data['passwordHash'] = this.passwordHash;
    data['passwordSalt'] = this.passwordSalt;
    data['role'] = this.role;
    data['citizenIdentificationInfoNumber'] =
        this.citizenIdentificationInfoNumber;
    data['citizenIdentificationInfoAddress'] =
        this.citizenIdentificationInfoAddress;
    data['citizenIdentificationInfoDateReceive'] =
        this.citizenIdentificationInfoDateReceive;
    data['passportInfoNumber'] = this.passportInfoNumber;
    data['passportInfoAddress'] = this.passportInfoAddress;
    data['passportInfoDateReceive'] = this.passportInfoDateReceive;
    data['createdDate'] = this.createdDate;
    data['isDeleted'] = this.isDeleted;
    data['parkingLot'] = this.parkingLot;
    // if (this.appraisalRecords != null) {
    //   data['appraisalRecords'] =
    //       this.appraisalRecords!.map((v) => v.toJson()).toList();
    // }
    // if (this.contractGroups != null) {
    //   data['contractGroups'] =
    //       this.contractGroups!.map((v) => v.toJson()).toList();
    // }
    // if (this.receiveContracts != null) {
    //   data['receiveContracts'] =
    //       this.receiveContracts!.map((v) => v.toJson()).toList();
    // }
    // if (this.rentContracts != null) {
    //   data['rentContracts'] =
    //       this.rentContracts!.map((v) => v.toJson()).toList();
    // }
    // if (this.transferContracts != null) {
    //   data['transferContracts'] =
    //       this.transferContracts!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
