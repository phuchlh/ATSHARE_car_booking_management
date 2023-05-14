class CarExpense {
  int? id;
  int? carId;
  String? title;
  String? day;
  int? amount;

  CarExpense({this.id, this.carId, this.title, this.day, this.amount});

  CarExpense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['carId'];
    title = json['title'];
    day = json['day'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carId'] = this.carId;
    data['title'] = this.title;
    data['day'] = this.day;
    data['amount'] = this.amount;
    return data;
  }
}
