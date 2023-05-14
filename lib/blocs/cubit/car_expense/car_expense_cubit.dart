import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/models/car_expense.dart';
import 'package:booking_car/models/car_expense_post.dart';
import 'package:booking_car/resources/remote/car_expense_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_expense_state.dart';

class CarExpenseCubit extends Cubit<CarExpenseState> {
  late CarExpenseState newExpense;
  CarExpenseCubit()
      : newExpense = CarExpenseState(),
        super(CarExpenseState());

  init() {
    emit(state.copyWith(isEdit: false));
  }

  Future<void> getCarExpense(int carId) async {
    try {
      emit(state.copyWith(status: CarExpenseStatus.loading));
      final carExpenses = await CarExpenseService().getCarExpenses(carId);
      if (carExpenses != null) {
        emit(state.copyWith(status: CarExpenseStatus.succcess, listExpense: carExpenses));
      } else {
        emit(state.copyWith(status: CarExpenseStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarExpenseStatus.error, message: e.message));
    }
  }

  onChangeTitleExpense(String? title) {
    newExpense = state.copyWith(title: title);
    emit(newExpense);
  }

  onChangeAmountExpense(String? amountString) {
    int amountInt = 0;
    String amountParsed = amountString == "" ? "0" : amountString!;
    amountInt = int.parse(amountParsed);
    newExpense = state.copyWith(amount: amountInt);
    emit(newExpense);
  }

  Future<void> postCarExpense(CarExpensePost car) async {
    try {
      emit(state.copyWith(status: CarExpenseStatus.loading));
      final carExpenses = await CarExpenseService().postCarExpense(car);
      if (carExpenses == CarExpenseStatus.succcess) {
        emit(state.copyWith(status: CarExpenseStatus.succcess));
      } else {
        emit(state.copyWith(status: CarExpenseStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: CarExpenseStatus.error, message: e.message));
    }
  }
}
