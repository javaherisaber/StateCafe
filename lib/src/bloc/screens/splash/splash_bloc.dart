import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    _initializeTimer();
    on<SplashIsFinished>(_onFinished);
  }

  void _initializeTimer() async {
    await Future.delayed(const Duration(seconds: 4));
    add(SplashIsFinished());
  }

  void _onFinished(SplashIsFinished event, Emitter<SplashState> emit) async {
    final isLoggedIn = await AppSharedPreferences.isLoggedIn;
    if (isLoggedIn) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToLogin());
    }
  }
}