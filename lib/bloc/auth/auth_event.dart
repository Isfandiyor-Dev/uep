import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationSignUp extends AuthenticationEvent {
  final Map<String, dynamic> data;
  const AuthenticationSignUp({required this.data});

  @override
  List<Object> get props => [data];
}

class AuthenticationSignIn extends AuthenticationEvent {
  final Map<String, dynamic> data;
  const AuthenticationSignIn({required this.data});

  @override
  List<Object> get props => [data];
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
