import 'package:booking_car/blocs/bloc/auth/auth_bloc.dart';
import 'package:booking_car/resources/repositories/repositories.dart';
import 'package:booking_car/screens/auth/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  const LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(create: (context) {
        return LoginBloc(userRepository: userRepository, authBloc: BlocProvider.of<AuthBloc>(context));
      },
      child: LoginForm(userRepository: userRepository,),),
    );
  }
}
