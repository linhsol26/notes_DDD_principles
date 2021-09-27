import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/application/auth/authentication_bloc.dart';
import 'package:notes/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) =>
              AutoRouter.of(context).replace(const HomeRoute()),
          unauthenticated: (_) =>
              AutoRouter.of(context).replace(const SignInRoute()),
        );
      },
      child: const Scaffold(
        body: Center(
          child: Text('Splash Page'),
        ),
      ),
    );
  }
}
