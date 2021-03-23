part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class TokenFetchingEvent extends LoginEvent {}

class LoginFetchingEvent extends LoginEvent {
  final String username;
  final String password;

  LoginFetchingEvent(this.username, this.password);
}

class SessionFetchingEvent extends LoginEvent {}

class FavouriteListFetchingEvent extends LoginEvent {}

class FetchedEvent extends LoginEvent {}

class FailedEvent extends LoginEvent {}
