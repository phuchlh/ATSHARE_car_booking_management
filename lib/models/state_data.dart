// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field
import 'dart:convert';

import 'package:booking_car/constants.dart';
import 'package:booking_car/models/user.dart';

class StateData<T> {
  final T? _data;
  late final LoadingState _state;
  final String? _errorMessage;

  StateData({T? data, LoadingState? state, String? errorMessage})
      : _data = data,
        _state = LoadingState.initial,
        _errorMessage = errorMessage;
}

StateData<User> userState = StateData<User>();
