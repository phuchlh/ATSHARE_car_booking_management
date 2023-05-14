class CarExpensePost {
  int? carId;
  String? title;
  String? day;
  int? amount;

  CarExpensePost({this.carId, this.title, this.day, this.amount});

  CarExpensePost.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    title = json['title'];
    day = json['day'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = this.carId;
    data['title'] = this.title;
    data['day'] = this.day;
    data['amount'] = this.amount;
    return data;
  }
}
