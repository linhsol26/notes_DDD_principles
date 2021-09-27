import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/domain/auth/i_auth_facade.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthFacade _authFacade;
  AuthenticationBloc(this._authFacade)
      : super(const AuthenticationState.initial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    yield* event.map(
      authCheckRequested: (e) async* {
        final userOption = await _authFacade.fetchSession();
        print(userOption);
        yield userOption
            ? const AuthenticationState.authenticated()
            : const AuthenticationState.unauthenticated();
      },
      signOut: (e) async* {
        await _authFacade.signOut();
        yield const AuthenticationState.unauthenticated();
      },
    );
  }
}
