import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/domain/auth/auth_failure.dart';
import 'package:notes/domain/auth/email_address.dart';
import 'package:notes/domain/auth/i_auth_facade.dart';
import 'package:notes/domain/auth/password.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none(),
        );
      },
      signInWithEmailAndPasswordPressed: (e) async* {
        Either<AuthFailure, Unit>? failureOrSuccess;

        final isEmailValid = state.emailAddress.isValid();
        final isPasswordValid = state.password.isValid();

        if (isEmailValid && isPasswordValid) {
          yield state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          );

          failureOrSuccess = await _authFacade.signInWithEmailPassword(
            emailAddress: state.emailAddress,
            password: state.password,
          );
        }

        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: optionOf(failureOrSuccess),
        );
      },
    );
  }
}