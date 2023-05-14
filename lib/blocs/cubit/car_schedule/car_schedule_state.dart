part of 'car_schedule_cubit.dart';

enum CarScheduleStatus {
  initial,
  loading,
  succcess,
  error,
  loadMore,
}

class CarScheduleState extends Equatable {
  final List<CarScheduleModel> listSchedule;
  final CarScheduleStatus status;
  final bool isEdit;
  final String? message;
  const CarScheduleState({
    this.listSchedule = const [],
    this.status = CarScheduleStatus.initial,
    this.isEdit = false,
    this.message,
  });

  CarScheduleState copyWith({
    CarScheduleStatus? status,
    List<CarScheduleModel>? listSchedule,
    bool? isEdit,
    String? message,
  }) {
    return CarScheduleState(
      listSchedule: listSchedule ?? this.listSchedule,
      status: status ?? this.status,
      isEdit: isEdit ?? this.isEdit,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        listSchedule,
        status,
        isEdit,
        message,
      ];
}
