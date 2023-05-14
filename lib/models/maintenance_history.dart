import 'package:booking_car/models/car.dart';

class MaintenanceHistory {
  int? id;
  int? carId;
  int? carKmlastMaintenance;
  int? kmTraveled;
  String? maintenanceDate;
  String? maintenanceInvoice;
  int? maintenanceAmount;
  Car? car;

  MaintenanceHistory(
      {this.id,
      this.carId,
      this.carKmlastMaintenance,
      this.kmTraveled,
      this.maintenanceDate,
      this.maintenanceInvoice,
      this.maintenanceAmount,
      this.car});

  MaintenanceHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['carId'];
    carKmlastMaintenance = json['carKmlastMaintenance'];
    kmTraveled = json['kmTraveled'];
    maintenanceDate = json['maintenanceDate'];
    maintenanceInvoice = json['maintenanceInvoice'];
    maintenanceAmount = json['maintenanceAmount'];
    car = json['car'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carId'] = this.carId;
    data['carKmlastMaintenance'] = this.carKmlastMaintenance;
    data['kmTraveled'] = this.kmTraveled;
    data['maintenanceDate'] = this.maintenanceDate;
    data['maintenanceInvoice'] = this.maintenanceInvoice;
    data['maintenanceAmount'] = this.maintenanceAmount;
    data['car'] = this.car;
    return data;
  }
}
