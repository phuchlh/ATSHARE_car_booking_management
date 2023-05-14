class TransferContractFileDataModels {
  int? id;
  int? transferContractId;
  String? title;
  String? documentImg;
  String? documentDescription;

  TransferContractFileDataModels(
      {this.id,
      this.transferContractId,
      this.title,
      this.documentImg,
      this.documentDescription});

  TransferContractFileDataModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transferContractId = json['transferContractId'];
    title = json['title'];
    documentImg = json['documentImg'];
    documentDescription = json['documentDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transferContractId'] = this.transferContractId;
    data['title'] = this.title;
    data['documentImg'] = this.documentImg;
    data['documentDescription'] = this.documentDescription;
    return data;
  }
}
