import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/auth/auth_state.dart';
import 'package:uep/services/auth_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;

  AuthenticationBloc(this.authService) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onStarted);
    on<AuthenticationSignUp>(_onSignUp);
    on<AuthenticationSignIn>(_onSignIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
  }

  Future<void> _onStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());

    final bool isAuthenticated = await authService.isAuthenticated();

    print("Auth holati: $isAuthenticated");
    if (isAuthenticated) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onSignUp(
    AuthenticationSignUp event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await authService.signUp(event.data);
      final bool isAuthenticated = await authService.isAuthenticated();

      if (isAuthenticated) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    } catch (e) {
      emit(AuthenticationFailure(error: 'Sign up failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignIn(
    AuthenticationSignIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await authService.signIn(event.data);
      emit(AuthenticationAuthenticated());
    } catch (e) {
      emit(AuthenticationFailure(error: 'Sign in failed: ${e.toString()}'));
    }
  }

  Future<void> _onLoggedOut(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await authService.logout();
      emit(AuthenticationUnauthenticated());
    } catch (e) {
      emit(AuthenticationFailure(error: 'Logout failed: ${e.toString()}'));
    }
  }
}
