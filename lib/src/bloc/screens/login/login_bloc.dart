import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(): super(const LoginInitial()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginConfirmClicked>(_onConfirmClicked);
  }

  void _onUsernameChanged(LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(LoginChangeCredentials(event.username, state.password));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(LoginChangeCredentials(state.username, event.password));
  }

  void _onConfirmClicked(LoginConfirmClicked event, Emitter<LoginState> emit) async {
    final username = state.username;
    final password = state.password;
    if (username == LoginState.defaultUsername && password == LoginState.defaultPassword) {
      await AppSharedPreferences.setIsLoggedIn(true);
      emit(LoginNavigateToHome(state));
    } else {
      Fluttertoast.showToast(msg: 'Wrong username or password');
    }
  }
}