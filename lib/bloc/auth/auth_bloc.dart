import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/auth/auth_state.dart';
import 'package:uep/services/auth_service.dart';

enum SocialLoginTypes { google, facebook, github }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;

  AuthenticationBloc(this.authService) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onStarted);
    on<AuthenticationSignUp>(_onSignUp);
    on<AuthenticationSignIn>(_onSignIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
    on<SocialLoginEvent>(_onSocialLogin);
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

  void _onSocialLogin(
    SocialLoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      Map<String, dynamic>? data;
      switch (event.type) {
        case SocialLoginTypes.google:
          const List<String> scopes = <String>['email'];
          final googleSignIn = GoogleSignIn(scopes: scopes);
          final googleUser = await googleSignIn.signIn();

          print("Bu name: ${googleUser?.displayName}");
          print("Bu email: ${googleUser?.email}");

          if (googleUser != null) {
            data = {
              "name": googleUser.displayName ?? '',
              "email": googleUser.email,
            };
          }
          break;
        case SocialLoginTypes.facebook:
          final result = await FacebookAuth.instance.login();
          if (result.status == LoginStatus.success) {
            final userData = await FacebookAuth.i.getUserData(
              fields: "name,email",
            );
            data = {
              "name": userData['name'] ?? '',
              "email": userData['email'],
            };
          }
          break;
        default:
          return;
      }

      if (data != null) {
        await authService.socialLogin(data);
        emit(AuthenticationAuthenticated());
      } else {
        throw ('User not found');
      }
    } catch (e) {
      print("Xatolik s.a: $e");
      // emit(AuthenticationFailure(error: ));
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
      emit(AuthenticationFailure(error: (e as Map<String, dynamic>)));
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
      emit(AuthenticationFailure(error: (e as Map<String, dynamic>)));
    }
  }

  Future<void> _onLoggedOut(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    // emit(AuthenticationLoading());
    try {
      await authService.logout();
      add(AuthenticationStarted());
      // emit(AuthenticationUnauthenticated());
    } catch (e) {
      emit(AuthenticationFailure(error: (e as Map<String, dynamic>)));
    }
  }
}
