part of 'rent_contract_cubit.dart';

enum RentStatus { initial, loading, succcess, error }

class RentContractState extends Equatable {
  final RentContract? rentContract;
  final RentStatus status;
  final String? message;
  final bool? isEdit;
  final int? paymentAmount;

  const RentContractState({
    this.isEdit = false,
    this.rentContract,
    this.status = RentStatus.initial,
    this.message,
    this.paymentAmount,
  });

  RentContractState copyWith({
    bool? isEdit,
    RentContract? rentContract,
    RentStatus? status,
    String? message,
    int? paymentAmount,
  }) {
    return RentContractState(
      isEdit: isEdit ?? this.isEdit,
      rentContract: rentContract ?? this.rentContract,
      status: status ?? this.status,
      message: message ?? this.message,
      paymentAmount: paymentAmount ?? this.paymentAmount,
    );
  }

  @override
  List<Object?> get props => [rentContract, status, message, isEdit, paymentAmount];
}
