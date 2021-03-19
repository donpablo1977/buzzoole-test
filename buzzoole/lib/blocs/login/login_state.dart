part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class InitialState extends LoginState {}

class FetchingState extends LoginState {}

class FetchedState extends LoginState {}

class FailedState extends LoginState {}
