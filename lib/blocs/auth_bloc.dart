import 'package:flutter_bloc/flutter_bloc.dart';

class AuthEvent {}
class AuthLogin extends AuthEvent {
  final String username;
  final String password;

  AuthLogin(this.username, this.password);
}
class AuthLogout extends AuthEvent {}

class AuthState {}
class AuthInitial extends AuthState {}
class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);
}
class Unauthenticated extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogin) {
      final user = authRepository.authenticate(event.username, event.password);
      if (user != null) {
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } else if (event is AuthLogout) {
      yield Unauthenticated();
    }
  }
}
