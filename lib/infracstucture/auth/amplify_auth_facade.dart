import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/domain/auth/auth_failure.dart';
import 'package:notes/domain/auth/email_address.dart';
import 'package:notes/domain/auth/i_auth_facade.dart';
import 'package:notes/domain/auth/password.dart';

@LazySingleton(as: IAuthFacade)
class AmplifyAuthFacade implements IAuthFacade {
  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    log(emailAddressStr);
    log(passwordStr);
    try {
      await Amplify.Auth.signIn(
        username: emailAddressStr,
        password: passwordStr,
      );
      return right(unit);
    } on AuthException catch (e) {
      if (e.message == "invalidUsername" ||
          e.message == "emptyPassword" ||
          e.message == "emptyUsername") {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<bool> fetchSession() async => Amplify.Auth.fetchAuthSession(
          // options: CognitoSessionOptions(getAWSCredentials: false),
          )
      .then((authSession) => authSession.isSignedIn);

  @override
  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
