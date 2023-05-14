part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;
  final String email;

  const LoggedIn({required this.token, required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [token];

  @override
  String toString() {
    // TODO: implement toString
    return "Logged in(token: $token)";
  }
}

class Logout extends AuthEvent {}
