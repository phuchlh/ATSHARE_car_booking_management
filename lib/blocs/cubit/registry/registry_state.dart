part of 'registry_cubit.dart';

enum RegistryStatus { initial, loading, succcess, error }

class RegistryState extends Equatable {
  final RegistryStatus status;
  final Car? carRegistry;
  final List<Car> carRegistries;
  final List<Car> allCarRegistries;
  final bool hasReachedMax;
  final String? message;
  final bool isEdit;

  const RegistryState({
    this.carRegistry,
    this.carRegistries = const [],
    this.allCarRegistries = const [],
    this.status = RegistryStatus.initial,
    this.hasReachedMax = false,
    this.message,
    this.isEdit = false,
  });

  RegistryState copyWith({
    Car? carRegistry,
    List<Car>? carRegistries,
    List<Car>? allCarRegistries,
    RegistryStatus? status,
    String? message,
    bool? isEdit,
    bool? hasReachedMax,
  }) {
    return RegistryState(
      carRegistry: carRegistry ?? this.carRegistry,
      carRegistries: carRegistries ?? this.carRegistries,
      allCarRegistries: allCarRegistries ?? this.allCarRegistries,
      status: status ?? this.status,
      message: message ?? this.message,
      isEdit: isEdit ?? this.isEdit,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props =>
      [carRegistry, carRegistries, allCarRegistries, status, message, isEdit, hasReachedMax];
}
