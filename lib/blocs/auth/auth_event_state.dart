import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends AuthEvent {
  final String username;
  final String password;

  const SignUp({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogIn extends AuthEvent {
  final String username;
  final String password;

  const LogIn({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogOut extends AuthEvent {}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  get userId => null;
}

class AuthFailed extends AuthState {}
