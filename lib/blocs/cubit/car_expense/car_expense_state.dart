part of 'car_expense_cubit.dart';

enum CarExpenseStatus { initial, loading, succcess, error, loadMore }

class CarExpenseState extends Equatable {
  final List<CarExpense> listExpense;
  final CarExpenseStatus status;
  final String message;
  final bool isEdit;
  final CarExpense? carExpense;
  final String? title;
  final DateTime? date;
  final int? amount;

  const CarExpenseState({
    this.listExpense = const [],
    this.status = CarExpenseStatus.initial,
    this.message = '',
    this.carExpense,
    this.isEdit = false,
    this.title,
    this.date,
    this.amount,
  });

  CarExpenseState copyWith({
    List<CarExpense>? listExpense,
    CarExpenseStatus? status,
    String? message,
    CarExpense? carExpense,
    bool? isEdit,
    String? title,
    DateTime? date,
    int? amount,
  }) {
    return CarExpenseState(
      listExpense: listExpense ?? this.listExpense,
      status: status ?? this.status,
      message: message ?? this.message,
      carExpense: carExpense ?? this.carExpense,
      isEdit: isEdit ?? this.isEdit,
      title: title ?? this.title,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [
        listExpense,
        status,
        message,
        carExpense,
        isEdit,
        title,
        date,
        amount,
      ];
}
