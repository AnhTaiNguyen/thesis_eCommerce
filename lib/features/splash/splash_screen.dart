import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/application/blocs/auth/authentication_bloc_bloc.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      () => Navigator.pushNamed(context, '/SignIn'),
    );

    return BlocListener<AuthenticationBloc, AuthenticationBlocState>(
      listenWhen: (previous, current) =>
          current is AuthenticationBlocInitial ||
          current is AuthenticationSuccess,
      listener: (context, state) {
        print('Splash screen Auth Listener');
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/images/logo2.png'),
                width: 125,
                height: 125,
              ),
            ),
            SizedBox(height: 30),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                'AnhTai Demo',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
