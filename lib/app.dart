import 'package:eCommerce/features/authentication/presentation/views/signin_screen.dart';
import 'package:eCommerce/features/formValidation/signupView.dart';
import 'package:eCommerce/screens/home_screen.dart';
import 'package:eCommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/application/blocs/auth/authentication_bloc_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocNavigate(),
      title: Constants.title,
    );
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return HomeScreen();
        } else {
          return SignInView();
        }
      },
    );
  }
}
