// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_car/models/transfer_contract_files_data_model.dart';
import 'package:booking_car/models/transfer_model.dart';

class TransferPut {
  int? id;
  int? transfererId;
  int? contractGroupId;
  String? dateTransfer;
  String? deliveryAddress;
  int? currentCarStateSpeedometerNumber;
  int? currentCarStateFuelPercent;
  int? currentCarStateCurrentEtcAmount;
  String? currentCarStateCarStatusDescription;
  int? depositItemDownPayment;
  String? depositItemAsset;
  String? depositItemDescription;
  bool? isExported;
  String? customerSignature;
  String? staffSignature;
  int? contractStatusId;
  List<TransferContractFileDataModels>? transferContractFileDataModels;
  TransferPut({
    this.id,
    this.transfererId,
    this.contractGroupId,
    this.dateTransfer,
    this.deliveryAddress,
    this.currentCarStateSpeedometerNumber,
    this.currentCarStateFuelPercent,
    this.currentCarStateCurrentEtcAmount,
    this.currentCarStateCarStatusDescription,
    this.depositItemDownPayment,
    this.depositItemAsset,
    this.depositItemDescription,
    this.isExported,
    this.customerSignature,
    this.staffSignature,
    this.contractStatusId,
    this.transferContractFileDataModels,
  });

  TransferPut copyWith({
    int? id,
    int? transfererId,
    int? contractGroupId,
    String? dateTransfer,
    String? deliveryAddress,
    int? currentCarStateSpeedometerNumber,
    int? currentCarStateFuelPercent,
    int? currentCarStateCurrentEtcAmount,
    String? currentCarStateCarStatusDescription,
    int? depositItemDownPayment,
    String? depositItemAsset,
    String? depositItemDescription,
    bool? isExported,
    String? customerSignature,
    String? staffSignature,
    int? contractStatusId,
    List<TransferContractFileDataModels>? transferContractFileDataModels,
  }) {
    return TransferPut(
      id: id ?? this.id,
      transfererId: transfererId ?? this.transfererId,
      contractGroupId: contractGroupId ?? this.contractGroupId,
      dateTransfer: dateTransfer ?? this.dateTransfer,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      currentCarStateSpeedometerNumber: currentCarStateSpeedometerNumber ?? this.currentCarStateSpeedometerNumber,
      currentCarStateFuelPercent: currentCarStateFuelPercent ?? this.currentCarStateFuelPercent,
      currentCarStateCurrentEtcAmount: currentCarStateCurrentEtcAmount ?? this.currentCarStateCurrentEtcAmount,
      currentCarStateCarStatusDescription: currentCarStateCarStatusDescription ?? this.currentCarStateCarStatusDescription,
      depositItemDownPayment: depositItemDownPayment ?? this.depositItemDownPayment,
      depositItemAsset: depositItemAsset ?? this.depositItemAsset,
      depositItemDescription: depositItemDescription ?? this.depositItemDescription,
      isExported: isExported ?? this.isExported,
      customerSignature: customerSignature ?? this.customerSignature,
      staffSignature: staffSignature ?? this.staffSignature,
      contractStatusId: contractStatusId ?? this.contractStatusId,
      transferContractFileDataModels: transferContractFileDataModels ?? this.transferContractFileDataModels,
    );
  }

  TransferPut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transfererId = json['transfererId'];
    contractGroupId = json['contractGroupId'];
    dateTransfer = json['dateTransfer'];
    deliveryAddress = json['deliveryAddress'];
    currentCarStateSpeedometerNumber = json['currentCarStateSpeedometerNumber'];
    currentCarStateFuelPercent = json['currentCarStateFuelPercent'];
    currentCarStateCurrentEtcAmount = json['currentCarStateCurrentEtcAmount'];
    currentCarStateCarStatusDescription = json['currentCarStateCarStatusDescription'];
    depositItemDownPayment = json['depositItemDownPayment'];
    depositItemAsset = json['depositItemAsset'];
    depositItemDescription = json['depositItemDescription'];
    isExported = json['isExported'];
    customerSignature = json['customerSignature'];
    staffSignature = json['staffSignature'];
    contractStatusId = json['contractStatusId'];
    if (json['transferContractFileDataModels'] != null) {
      transferContractFileDataModels = <TransferContractFileDataModels>[];
      json['transferContractFileDataModels'].forEach((v) {
        transferContractFileDataModels!.add(new TransferContractFileDataModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transfererId'] = this.transfererId;
    data['contractGroupId'] = this.contractGroupId;
    data['dateTransfer'] = this.dateTransfer;
    data['deliveryAddress'] = this.deliveryAddress;
    data['currentCarStateSpeedometerNumber'] = this.currentCarStateSpeedometerNumber;
    data['currentCarStateFuelPercent'] = this.currentCarStateFuelPercent;
    data['currentCarStateCurrentEtcAmount'] = this.currentCarStateCurrentEtcAmount;
    data['currentCarStateCarStatusDescription'] = this.currentCarStateCarStatusDescription;
    data['depositItemDownPayment'] = this.depositItemDownPayment;
    data['depositItemAsset'] = this.depositItemAsset;
    data['depositItemDescription'] = this.depositItemDescription;
    data['isExported'] = this.isExported;
    data['customerSignature'] = this.customerSignature;
    data['staffSignature'] = this.staffSignature;
    data['contractStatusId'] = this.contractStatusId;
    if (this.transferContractFileDataModels != null) {
      data['transferContractFileDataModels'] = this.transferContractFileDataModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory TransferPut.fromTransferModel(TransferModel model) {
    return TransferPut(
      id: model.id,
      transfererId: model.transfererId,
      contractGroupId: model.contractGroupId,
      dateTransfer: model.dateTransfer,
      deliveryAddress: model.deliveryAddress,
      currentCarStateSpeedometerNumber: model.currentCarStateSpeedometerNumber,
      currentCarStateFuelPercent: model.currentCarStateFuelPercent,
      currentCarStateCurrentEtcAmount: model.currentCarStateCurrentEtcAmount,
      currentCarStateCarStatusDescription: model.currentCarStateCarStatusDescription,
      depositItemDownPayment: model.depositItemDownPayment,
      depositItemAsset: model.depositItemAsset,
      depositItemDescription: model.depositItemDescription,
      isExported: model.isExported,
      customerSignature: model.customerSignature,
      staffSignature: model.staffSignature,
      contractStatusId: model.contractStatusId,
      transferContractFileDataModels: model.transferContractFileDataModels,
    );
  }
}
