part of 'authentication_bloc_bloc.dart';

abstract class AuthenticationBlocEvent extends Equatable {
  const AuthenticationBlocEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationBlocEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationSignedOut extends AuthenticationBlocEvent {
  @override
  List<Object> get props => [];
}
