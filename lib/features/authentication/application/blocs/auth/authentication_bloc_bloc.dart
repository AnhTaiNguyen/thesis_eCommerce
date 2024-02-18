import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/userModel.dart';
import '../../authentication_repository.dart';

part 'authentication_bloc_event.dart';
part 'authentication_bloc_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationBlocEvent>((event, emit) async {
      // if (event is AuthenticationBlocInitial) {
      //   UserModel user = await _authenticationRepository.getCurrentUser().first;
      //   String? displayName =
      //       await _authenticationRepository.retrieveUserName(user);
      //   if (user.uid != null) {
      //     print(user.uid);
      //     emit(AuthenticationSuccess(
      //         displayName: displayName,
      //         age: user.age,
      //         email: user.email,
      //         password: user.password,
      //         isVerified: user.isVerified,
      //         phone: user.phone));
      //   }
      // }
      if (event is AuthenticationStarted ||
          event is AuthenticationBlocInitial) {
        UserModel user = await _authenticationRepository.getCurrentUser().first;
        String? displayName =
            await _authenticationRepository.retrieveUserName(user);
        if (user.id != null) {
          print(user.id);
          emit(AuthenticationSuccess(
              displayName: displayName,
              age: user.age,
              email: user.email,
              password: user.password,
              isVerified: user.isVerified,
              phone: user.phone));
        } else {
          emit(AuthenticationFailure());
        }
      } else if (event is AuthenticationSignedOut) {
        await _authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
