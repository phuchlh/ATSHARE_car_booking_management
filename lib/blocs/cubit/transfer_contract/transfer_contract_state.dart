// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transfer_contract_cubit.dart';

enum TransferContractStatus { initial, loading, succcess, error }

class TransferContractState extends Equatable {
  final TransferModel? transferModel;
  final TransferContractStatus status;
  final String? message;
  final bool isEdit;
  final File? staffSignature;
  final File? customerSignature;
  final int? speedoNumber;
  final int? fuelPercentage;
  final int? etcAmount;
  final String? statusDescription;

  TransferContractState({
    this.transferModel,
    this.staffSignature,
    this.customerSignature,
    this.isEdit = false,
    this.message,
    this.status = TransferContractStatus.initial,
    this.speedoNumber,
    this.fuelPercentage,
    this.etcAmount,
    this.statusDescription,
  });

  TransferContractState copyWith({
    TransferModel? transferModel,
    bool? isEdit,
    TransferContractStatus? status,
    String? message,
    File? staffSignature,
    File? customerSignature,
    int? speedoNumber,
    int? fuelPercentage,
    int? etcAmount,
    String? statusDescription,
  }) {
    return TransferContractState(
      transferModel: transferModel ?? this.transferModel,
      isEdit: isEdit ?? this.isEdit,
      status: status ?? this.status,
      message: message ?? this.message,
      staffSignature: staffSignature ?? this.staffSignature,
      customerSignature: customerSignature ?? this.customerSignature,
      speedoNumber: speedoNumber ?? this.speedoNumber,
      fuelPercentage: fuelPercentage ?? this.fuelPercentage,
      etcAmount: etcAmount ?? this.etcAmount,
      statusDescription: statusDescription ?? this.statusDescription,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        isEdit,
        transferModel,
        staffSignature,
        customerSignature,
        speedoNumber,
        fuelPercentage,
        etcAmount,
        statusDescription,
      ];
}
