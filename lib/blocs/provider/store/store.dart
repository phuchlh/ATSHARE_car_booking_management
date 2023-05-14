import 'package:booking_car/resources/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

class Store {
  NavigatorState? get _navigator => Global.useCurrentState();

  List<SingleChildWidget> getProviders() =>
      [BlocListener(listener: (context, state) {})];
}
