import 'package:booking_car/models/user.dart';
import 'package:booking_car/resources/remote/user_services.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  init() {
    emit(state.copyWith(status: UserStatus.initial));
  }

  Future<void> getUser(String email) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      final userObj = await UserService().getUserIdByEmail(email);
      if (userObj != null) {
        emit(state.copyWith(status: UserStatus.succcess, user: userObj));
      } else {
        emit(state.copyWith(status: UserStatus.error, message: 'Error'));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: UserStatus.error, message: e.message));
    }
  }
}
