part of 'car_info_cubit.dart';

enum InfoLoading { initial, loading, succcess, error }

class InfoState extends Equatable {
  final bool isEdit;
  final InfoLoading status;
  final String? message;
  final List<CarInfo> carStatus;
  final List<CarInfo> carMake;

  const InfoState({
    this.status = InfoLoading.initial,
    this.isEdit = false,
    this.message,
    this.carStatus = const [],
    this.carMake = const [],
  });

  InfoState copyWith({
    bool? isEdit,
    List<CarInfo>? carStatus,
    InfoLoading? status,
    String? message,
    List<CarInfo>? carMake,
  }) {
    return InfoState(
      message: message ?? this.message,
      isEdit: isEdit ?? this.isEdit,
      status: status ?? this.status,
      carStatus: carStatus ?? this.carStatus,
      carMake: carMake ?? this.carMake,
    );
  }

  @override
  List<Object?> get props => [status, message, isEdit, carStatus, carMake];
}
