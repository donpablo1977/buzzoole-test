part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class InitialState extends LoginState {}

class FetchingState extends LoginState {}

class TokenFetchedState extends LoginState {}

class SessionFetchedState extends LoginState {}

class LoginFetchedState extends LoginState {}

class FailedState extends LoginState {}
