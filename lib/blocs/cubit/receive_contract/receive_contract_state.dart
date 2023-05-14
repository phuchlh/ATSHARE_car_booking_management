part of 'receive_contract_cubit.dart';

enum ReceiveContractStatus {
  initial,
  loading,
  success,
  failure,
}

class ReceiveContractState extends Equatable {
  final int? insurance;
  final ReceiveContractStatus status;
  final ReceivePost? receiveContract;
  final ReceiveModel? response;
  final bool isEdit;
  final String? message;
  final String? overSpeeds;
  final String? roadViolates;
  final String? passingRedLights;
  final String? anotherViolations;
  final bool? isReturnDeposit;
  final bool? isTrafficViolation;
  final int? overHours;
  final int? violationMoney;
  final int? currentFuelMoney;

  const ReceiveContractState({
    this.status = ReceiveContractStatus.initial,
    this.response,
    this.receiveContract,
    this.insurance,
    this.overHours,
    this.isEdit = false,
    this.isReturnDeposit = true,
    this.isTrafficViolation = false,
    this.overSpeeds,
    this.roadViolates,
    this.passingRedLights,
    this.anotherViolations,
    this.violationMoney,
    this.currentFuelMoney,
    this.message,
  });

  ReceiveContractState copyWith({
    ReceiveContractStatus? status,
    ReceivePost? receiveContract,
    ReceiveModel? response,
    bool? isEdit,
    bool? isReturnDeposit,
    bool? isTrafficViolation,
    int? insurance,
    String? overSpeeds,
    int? overHours,
    String? roadViolates,
    String? passingRedLights,
    String? anotherViolations,
    int? violationMoney,
    int? currentFuelMoney,
    String? message,
  }) {
    return ReceiveContractState(
      insurance: insurance ?? this.insurance,
      status: status ?? this.status,
      receiveContract: receiveContract ?? this.receiveContract,
      response: response ?? this.response,
      isEdit: isEdit ?? this.isEdit,
      overHours: overHours ?? this.overHours,
      isTrafficViolation: isTrafficViolation ?? this.isTrafficViolation,
      isReturnDeposit: isReturnDeposit ?? this.isReturnDeposit,
      message: message ?? this.message,
      overSpeeds: overSpeeds ?? this.overSpeeds,
      roadViolates: roadViolates ?? this.roadViolates,
      passingRedLights: passingRedLights ?? this.passingRedLights,
      anotherViolations: anotherViolations ?? this.anotherViolations,
      violationMoney: violationMoney ?? this.violationMoney,
      currentFuelMoney: currentFuelMoney ?? this.currentFuelMoney,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        receiveContract,
        response,
        isEdit,
        message,
        insurance,
        overSpeeds,
        roadViolates,
        passingRedLights,
        anotherViolations,
        isReturnDeposit,
        overHours,
        isTrafficViolation,
        violationMoney,
        currentFuelMoney,
      ];
}
