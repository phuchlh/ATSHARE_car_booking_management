// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contract_group_cubit.dart';

enum ContractGroupStatus { initial, loading, succcess, error }

class ContractGroupState extends Equatable {
  final ContractGroup? contractGroup;
  final List<ContractGroup> contractGroups;
  final ContractGroupStatus status;
  final bool isEdit;
  final bool isDone;
  final String? message;

  const ContractGroupState({
    this.contractGroup,
    this.isDone = false,
    this.contractGroups = const [],
    this.status = ContractGroupStatus.initial,
    this.isEdit = false,
    this.message,
  });

  ContractGroupState copyWith({
    ContractGroup? contractGroup,
    List<ContractGroup>? contractGroups,
    ContractGroupStatus? status,
    bool? isEdit,
    String? message,
    bool? isDone,
  }) {
    return ContractGroupState(
      contractGroup: contractGroup ?? this.contractGroup,
      contractGroups: contractGroups ?? this.contractGroups,
      status: status ?? this.status,
      message: message ?? this.message,
      isDone: isDone ?? this.isDone,
      isEdit: isEdit ?? this.isEdit,
    );
  }

  @override
  List<Object?> get props =>
      [contractGroup, contractGroups, status, message, isEdit, isDone];
}
