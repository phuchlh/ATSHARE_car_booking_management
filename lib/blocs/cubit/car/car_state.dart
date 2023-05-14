part of 'car_cubit.dart';

enum CarStatus {
  initial,
  loading,
  succcess,
  error,
  loadMore,
  // scheduleInit,
  // scheduleSuccess,
  // scheduleError,
  // scheduleLoading,
}

class CarState extends Equatable {
  final Car? car;
  final List<Car> cars; // list car hiện tại
  final List<Car> allCars; // list car đã load
  final CarStatus status;
  final bool isEdit;
  final bool hasReachedMax; //max danh sách xe hay chưa
  final bool isLoading; // đang load danh sách xe hay sao
  final String? message;
  final List<CarInfo> carStatus;
  final String? searchString;
  final String? filter;
  final int? speedoNumber;
  final int? fuelPercentage;
  final int? etcAmount;
  final String? statusDescription;
  final CarSchedulePost? carSchedulePost;
  final List<CarScheduleModel> listSchedule;

  const CarState({
    this.car,
    this.carStatus = const [],
    this.cars = const [],
    this.allCars = const [],
    this.status = CarStatus.initial,
    this.isEdit = false,
    this.hasReachedMax = false,
    this.isLoading = false,
    this.message,
    this.searchString,
    this.filter,
    this.speedoNumber,
    this.fuelPercentage,
    this.etcAmount,
    this.statusDescription,
    this.carSchedulePost,
    this.listSchedule = const [],
  });

  CarState copyWith({
    Car? car,
    List<Car>? cars,
    List<Car>? allCars,
    CarStatus? status,
    String? message,
    bool? isEdit,
    bool? hasReachedMax,
    bool? isLoading,
    List<CarInfo>? carStatus,
    String? searchString,
    String? filter,
    int? speedoNumber,
    int? fuelPercentage,
    int? etcAmount,
    String? statusDescription,
    CarSchedulePost? carSchedulePost,
    List<CarScheduleModel>? listSchedule,
  }) {
    return CarState(
      car: car ?? this.car,
      cars: cars ?? this.cars,
      allCars: allCars ?? this.allCars,
      status: status ?? this.status,
      message: message ?? this.message,
      isEdit: isEdit ?? this.isEdit,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      carStatus: carStatus ?? this.carStatus,
      searchString: searchString ?? this.searchString,
      filter: filter ?? this.filter,
      speedoNumber: speedoNumber ?? this.speedoNumber,
      fuelPercentage: fuelPercentage ?? this.fuelPercentage,
      etcAmount: etcAmount ?? this.etcAmount,
      statusDescription: statusDescription ?? this.statusDescription,
      carSchedulePost: carSchedulePost ?? this.carSchedulePost,
      listSchedule: listSchedule ?? this.listSchedule,
    );
  }

  @override
  List<Object?> get props => [
        car,
        cars,
        status,
        message,
        isEdit,
        carStatus,
        searchString,
        filter,
        allCars,
        hasReachedMax,
        isLoading,
        speedoNumber,
        fuelPercentage,
        etcAmount,
        statusDescription,
        carSchedulePost,
        listSchedule,
      ];
}
