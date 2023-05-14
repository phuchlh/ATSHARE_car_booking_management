class TransferContractFileCreateModels {
  String? title;
  String? documentImg;
  String? documentDescription;

  TransferContractFileCreateModels({this.title, this.documentImg, this.documentDescription});

  TransferContractFileCreateModels.fromJson(Map<String, dynamic> json) {
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
