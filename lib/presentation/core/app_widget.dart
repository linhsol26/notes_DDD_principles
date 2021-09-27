import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/amplifyconfiguration.dart';
import 'package:notes/application/auth/authentication_bloc.dart';
import 'package:notes/injection.dart';
import 'package:notes/presentation/routes/router.gr.dart';
import 'package:notes/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              getIt<AuthenticationBloc>()..add(const AuthCheckRequested()),
        )
      ],
      child: MaterialApp(
        home: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
        title: 'Notes',
      ),
    );
  }
}
