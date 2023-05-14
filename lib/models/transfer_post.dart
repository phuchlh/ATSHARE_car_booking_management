import 'package:booking_car/models/transfer_contract_files_create_model.dart';
import 'package:booking_car/models/transfer_model.dart';

class TransferPost {
  int? transfererId;
  int? contractGroupId;
  String? dateTransfer;
  String? deliveryAddress;
  int? currentCarStateSpeedometerNumber;
  int? currentCarStateFuelPercent;
  int? currentCarStateCurrentEtcAmount;
  String? currentCarStateCarStatusDescription;
  int? depositItemDownPayment;
  String? createdDate;
  List<TransferContractFileCreateModels>? transferContractFileCreateModels;

  TransferPost(
      {this.transfererId,
      this.contractGroupId,
      this.dateTransfer,
      this.deliveryAddress,
      this.currentCarStateSpeedometerNumber,
      this.currentCarStateFuelPercent,
      this.currentCarStateCurrentEtcAmount,
      this.currentCarStateCarStatusDescription,
      this.depositItemDownPayment,
      this.createdDate,
      this.transferContractFileCreateModels});

  TransferPost.fromJson(Map<String, dynamic> json) {
    transfererId = json['transfererId'];
    contractGroupId = json['contractGroupId'];
    dateTransfer = json['dateTransfer'];
    deliveryAddress = json['deliveryAddress'];
    currentCarStateSpeedometerNumber = json['currentCarStateSpeedometerNumber'];
    currentCarStateFuelPercent = json['currentCarStateFuelPercent'];
    currentCarStateCurrentEtcAmount = json['currentCarStateCurrentEtcAmount'];
    currentCarStateCarStatusDescription = json['currentCarStateCarStatusDescription'];
    depositItemDownPayment = json['depositItemDownPayment'];
    createdDate = json['createdDate'];
    if (json['transferContractFileCreateModels'] != null) {
      transferContractFileCreateModels = <TransferContractFileCreateModels>[];
      json['transferContractFileCreateModels'].forEach((v) {
        transferContractFileCreateModels!.add(new TransferContractFileCreateModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transfererId'] = this.transfererId;
    data['contractGroupId'] = this.contractGroupId;
    data['dateTransfer'] = this.dateTransfer;
    data['deliveryAddress'] = this.deliveryAddress;
    data['currentCarStateSpeedometerNumber'] = this.currentCarStateSpeedometerNumber;
    data['currentCarStateFuelPercent'] = this.currentCarStateFuelPercent;
    data['currentCarStateCurrentEtcAmount'] = this.currentCarStateCurrentEtcAmount;
    data['currentCarStateCarStatusDescription'] = this.currentCarStateCarStatusDescription;
    data['depositItemDownPayment'] = this.depositItemDownPayment;
    data['createdDate'] = this.createdDate;
    if (this.transferContractFileCreateModels != null) {
      data['transferContractFileCreateModels'] =
          this.transferContractFileCreateModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // factory TransferPost.fromTransferModel(TransferModel model) {
  //   return TransferPost(
  //     transfererId: model.transfererId,
  //     contractGroupId: model.contractGroupId,
  //     dateTransfer: model.dateTransfer,
  //     deliveryAddress: model.deliveryAddress,
  //     currentCarStateSpeedometerNumber: model.currentCarStateSpeedometerNumber,
  //     currentCarStateFuelPercent: model.currentCarStateFuelPercent,
  //     currentCarStateCurrentEtcAmount: model.currentCarStateCurrentEtcAmount,
  //     currentCarStateCarStatusDescription:
  //         model.currentCarStateCarStatusDescription,
  //     depositItemDownPayment: model.depositItemDownPayment,
  //     depositItemAsset: model.depositItemAsset,
  //     depositItemDescription: model.depositItemDescription,
  //     createdDate: model.createdDate,
  //     transferContractFileCreateModels: model.transferContractFileCreateModels,
  //   );
  // }
}
