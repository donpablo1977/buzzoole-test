part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class FetchingEvent extends AccountEvent {}

class FetchedEvent extends AccountEvent {}

class FailedEvent extends AccountEvent {}
