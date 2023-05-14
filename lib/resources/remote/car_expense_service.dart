import 'package:booking_car/blocs/cubit/car_expense/car_expense_cubit.dart';
import 'package:booking_car/models/car_expense.dart';
import 'package:booking_car/models/car_expense_post.dart';
import 'package:booking_car/resources/dio.dart';

String EXPENSE = '/carExpense';

class CarExpenseService {
  Future<List<CarExpense>?> getCarExpenses(int carID) async {
    try {
      final response = await DioClient.get('$EXPENSE/carId/$carID');
      if (response.statusCode == 200) {
        List<CarExpense> data =
            response.data.map<CarExpense>((e) => CarExpense.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<CarExpenseStatus> postCarExpense(CarExpensePost carExpense) async {
    try {
      final response = await DioClient.post('$EXPENSE/create', carExpense.toJson());
      if (response.statusCode == 200) {
        return CarExpenseStatus.succcess;
      } else {
        return CarExpenseStatus.error;
      }
    } catch (e) {
      throw e;
    }
  }
}
