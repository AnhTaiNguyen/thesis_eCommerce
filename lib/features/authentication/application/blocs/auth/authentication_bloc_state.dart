part of 'authentication_bloc_bloc.dart';

sealed class AuthenticationBlocState extends Equatable {
  const AuthenticationBlocState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationBlocState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationBlocState {
  final String? uid;
  final bool? isVerified;
  final String? email;
  final String? password;
  final String? displayName;
  final int? age;
  final int? phone;

  const AuthenticationSuccess({
    this.uid,
    this.email,
    this.password,
    this.displayName,
    this.age,
    this.isVerified,
    this.phone,
  });

  @override
  List<Object?> get props => [displayName, email, phone.toString()];
  List<Object?> get fullInformation =>
      [uid, email, password, displayName, age, isVerified];
}

class AuthenticationFailure extends AuthenticationBlocState {
  @override
  List<Object?> get props => [];
}

class AuthenticationBlocInitial extends AuthenticationBlocState {}
