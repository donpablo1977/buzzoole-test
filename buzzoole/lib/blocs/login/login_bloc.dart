import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buzzoole/data/models/auth.dart';
import 'package:buzzoole/data/models/request_token.dart';
import 'package:buzzoole/data/models/session.dart';
import 'package:buzzoole/data/repositories/login_repository.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(InitialState());

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield FetchingState();
    try {
      if (event is TokenFetchingEvent) {
        RequestToken _requestToken = await loginRepository.fetchRequestToken();
        if (_requestToken != null) {
          BuzzooleStrings().requestToken = _requestToken.requestToken;
          yield TokenFetchedState();
        } else {
          yield FailedState();
        }
      } else if (event is LoginFetchingEvent) {
        Auth _auth =
            await loginRepository.sendLoginData(event.username, event.password);
        if (_auth != null) {
          BuzzooleStrings().requestToken = _auth.requestToken;
          yield LoginFetchedState();
        } else {
          yield FailedState();
        }
      } else if (event is SessionFetchingEvent) {
        Session _session = await loginRepository.fetchSession();
        if (_session != null) {
          yield SessionFetchedState();
        } else {
          yield FailedState();
        }
      }
    } catch (e) {
      yield FailedState();
    }
  }
}
