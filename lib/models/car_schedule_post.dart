class CarSchedulePost {
  int? carId;
  String? dateStart;
  String? dateEnd;
  int? carStatusId;

  CarSchedulePost({this.carId, this.dateStart, this.dateEnd, this.carStatusId});

  CarSchedulePost.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    carStatusId = json['carStatusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = this.carId;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['carStatusId'] = this.carStatusId;
    return data;
  }
}
