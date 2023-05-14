class CarScheduleModel {
  int? id;
  int? carId;
  Null? carLicensePlates;
  String? dateStart;
  String? dateEnd;
  int? carStatusId;
  String? carStatusName;

  CarScheduleModel(
      {this.id,
      this.carId,
      this.carLicensePlates,
      this.dateStart,
      this.dateEnd,
      this.carStatusId,
      this.carStatusName});

  CarScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['carId'];
    carLicensePlates = json['carLicensePlates'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    carStatusId = json['carStatusId'];
    carStatusName = json['carStatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carId'] = this.carId;
    data['carLicensePlates'] = this.carLicensePlates;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['carStatusId'] = this.carStatusId;
    data['carStatusName'] = this.carStatusName;
    return data;
  }
}
