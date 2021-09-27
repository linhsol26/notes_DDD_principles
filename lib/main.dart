import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/amplifyconfiguration.dart';
import 'package:notes/injection.dart';
import 'package:notes/presentation/core/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  await _configureAmplify();
  runApp(
    // check if config right
    const AppWidget(),
  );
}

Future<void> _configureAmplify() async {
  await Amplify.addPlugins([AmplifyAuthCognito()]);
  await Amplify.configure(amplifyconfig);
}
