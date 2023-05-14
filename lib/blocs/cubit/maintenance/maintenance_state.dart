part of 'maintenance_cubit.dart';

enum MaintenanceStatus { initial, loading, succcess, error }

class MaintenanceState extends Equatable {
  final Car? carMaintenance;
  final List<Car> carMaintenances; // list cần bảo trì hiện tại
  final List<Car> allCarMaintenances; // list cần bảo trì đã load
  final MaintenanceStatus status;
  final bool isEdit;
  final String? message;
  final List<MaintenanceHistory> maintenanceHistory;
  final bool hasReachedMax; //max danh sách xe hay chưa

  const MaintenanceState({
    this.maintenanceHistory = const [],
    this.hasReachedMax = false,
    this.allCarMaintenances = const [],
    this.carMaintenance,
    this.carMaintenances = const [],
    this.status = MaintenanceStatus.initial,
    this.isEdit = false,
    this.message,
  });

  MaintenanceState copyWith({
    List<Car>? allCarMaintenances,
    Car? carMaintenance,
    List<Car>? carMaintenances,
    MaintenanceStatus? status,
    List<MaintenanceHistory>? maintenanceHistory,
    String? message,
    bool? isEdit,
    bool? hasReachedMax,
  }) {
    return MaintenanceState(
      maintenanceHistory: maintenanceHistory ?? this.maintenanceHistory,
      allCarMaintenances: allCarMaintenances ?? this.allCarMaintenances,
      carMaintenance: carMaintenance ?? this.carMaintenance,
      carMaintenances: carMaintenances ?? this.carMaintenances,
      status: status ?? this.status,
      message: message ?? this.message,
      isEdit: isEdit ?? this.isEdit,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        allCarMaintenances,
        carMaintenance,
        carMaintenances,
        status,
        message,
        maintenanceHistory,
        isEdit,
        hasReachedMax
      ];
}
