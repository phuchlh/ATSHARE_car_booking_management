class CarFile {
  int? id;
  int? carId;
  String? filePath;
  String? frontImg;
  String? backImg;
  String? leftImg;
  String? rightImg;
  String? ortherImg;
  String? createdDate;

  CarFile(
      {this.id,
      this.carId,
      this.filePath,
      this.frontImg,
      this.backImg,
      this.leftImg,
      this.rightImg,
      this.ortherImg,
      this.createdDate});

  CarFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['carId'];
    filePath = json['filePath'];
    frontImg = json['frontImg'];
    backImg = json['backImg'];
    leftImg = json['leftImg'];
    rightImg = json['rightImg'];
    ortherImg = json['ortherImg'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carId'] = this.carId;
    data['filePath'] = this.filePath;
    data['frontImg'] = this.frontImg;
    data['backImg'] = this.backImg;
    data['leftImg'] = this.leftImg;
    data['rightImg'] = this.rightImg;
    data['ortherImg'] = this.ortherImg;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
