import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../models/models.dart';
import 'auth_event_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Box userBox;

  AuthBloc({required this.userBox}) : super(AuthInitial()) {
    on<SignUp>(_onSignUp);
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  void _onSignUp(SignUp event, Emitter<AuthState> emit) {
    userBox.put(event.username, User(username: event.username, password: event.password));
    emit(Authenticated());
  }

  void _onLogIn(LogIn event, Emitter<AuthState> emit) {
    final user = userBox.get(event.username) as User?;
    if (user != null && user.password == event.password) {
      emit(Authenticated());
    } else {
      emit(AuthFailed());
    }
  }

  void _onLogOut(LogOut event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
