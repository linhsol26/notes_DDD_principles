import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/domain/auth/auth_failure.dart';
import 'package:notes/domain/auth/email_address.dart';
import 'package:notes/domain/auth/password.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> signInWithEmailPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<bool> fetchSession();
  Future<void> signOut();
}
