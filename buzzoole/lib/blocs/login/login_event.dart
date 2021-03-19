part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class FetchingEvent extends LoginEvent {}

class FetchedEvent extends LoginEvent {}

class FailedEvent extends LoginEvent {}
