// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_car/constants.dart';
import 'package:booking_car/models/contract_group_status.dart';
import 'package:equatable/equatable.dart';

class CategoriesState extends Equatable {
  LoadingState? loadingState;
  List<ContractGroupStatus>? listContractGroupStatus;

  CategoriesState({this.loadingState, this.listContractGroupStatus});

  CategoriesState copyWith({
    LoadingState? loadingState,
    List<ContractGroupStatus>? listContractGroupStatus,
  }) {
    return CategoriesState(
      loadingState: loadingState ?? this.loadingState,
      listContractGroupStatus:
          listContractGroupStatus ?? this.listContractGroupStatus,
    );
  }

  @override
  List<Object?> get props => [loadingState, listContractGroupStatus];
}
