import 'package:booking_car/blocs/bloc/login/login_bloc.dart';
import 'package:booking_car/resources/repositories/repositories.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  const LoginForm({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState(UserRepository userRepository);

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    _onLoginButtonPressed() {
      print(
          'pressed ${_emailFieldController.text} + ${_passwordFieldController.text}');
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          email: _emailFieldController.text,
          password: _passwordFieldController.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomSnackBar(),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
            child: Form(
              child: Column(
                children: [
                  Container(
                      height: 200.0,
                      padding: EdgeInsets.only(bottom: 20.0, top: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "ATSHARE",
                            style: TextStyle(
                                color: Color.fromARGB(255, 83, 129, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Dịch vụ cho thuê xe tự lái",
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black38),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                  myCustomeTextField(
                    context: context,
                    controller: _emailFieldController,
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    prefixIcon:
                        Icon(EvaIcons.emailOutline, color: Colors.black26),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  myCustomeTextField(
                    context: context,
                    controller: _passwordFieldController,
                    labelText: "Mật khẩu",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enableSuggestion: false,
                    prefixIcon:
                        Icon(EvaIcons.lockOutline, color: Colors.black26),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text(
                        "Quên mật khẩu?",
                        style: TextStyle(color: Colors.black45, fontSize: 12.0),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 45.0,
                          child: state is LoginLoading
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            height: 25.0,
                                            width: 25.0,
                                            child: CupertinoActivityIndicator(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 83, 129, 255),
                                      disabledBackgroundColor:
                                          Color.fromARGB(255, 83, 129, 255),
                                      disabledForegroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
                                  onPressed: _onLoginButtonPressed,
                                  child: Text(
                                    "Đăng nhập",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class myCustomeTextField extends StatelessWidget {
  const myCustomeTextField({
    Key? key,
    required this.context,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    required this.obscureText,
    this.enableSuggestion,
    required this.prefixIcon,
  }) : super(key: key);

  final BuildContext context;
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final Icon prefixIcon;
  final bool obscureText;
  final bool? enableSuggestion;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(30.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 83, 129, 255)),
            borderRadius: BorderRadius.circular(30.0)),
        contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        labelText: labelText,
        hintStyle: TextStyle(
            fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
        labelStyle: TextStyle(
            fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
      ),
      autocorrect: false,
    );
  }
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
            color: Color(0xFFC72C41),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Oh no!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Sai email hoặc mật khẩu, mời thử lại.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
